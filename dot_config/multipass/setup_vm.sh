#!/bin/bash

# --- 設定項目 ---
VM_NAME="dev"
CPU="2"
MEM="4G"
DISK="10G"
# chezmoi apply すると、ここにファイルが生成されるはずです
INIT_YAML="$HOME/.config/multipass/init.yaml"

echo "🚀 Multipass VM自動構築を開始します..."

# 1. 既存のVMがあれば削除
if multipass list | grep -q "$VM_NAME"; then
    echo "🗑️  既存のVM ($VM_NAME) を削除しています..."
    multipass delete "$VM_NAME"
    multipass purge
fi

# 2. VMを起動
echo "vm launching..."
# init.yaml が存在するかチェック
if [ ! -f "$INIT_YAML" ]; then
    echo "⚠️  警告: $INIT_YAML が見つかりません。デフォルト設定で起動します。"
    multipass launch --name "$VM_NAME" --cpus "$CPU" --memory "$MEM" --disk "$DISK"
else
    multipass launch --name "$VM_NAME" --cpus "$CPU" --memory "$MEM" --disk "$DISK" --cloud-init "$INIT_YAML"
fi

if [ $? -ne 0 ]; then
    echo "❌ VMの起動に失敗しました。"
    exit 1
fi

echo "✅ VMが起動しました。chezmoiを使ってセットアップします..."

# 3. VM内部でセットアップコマンドを実行
multipass exec "$VM_NAME" -- bash << 'EOF'
    set -e  # エラーが出たら即停止

    echo "📦 必須パッケージ (curl, git) をインストール中..."
    sudo apt update
    sudo apt install -y curl git

    echo "⚡️ chezmoi を初期化・適用中 (これに時間がかかります)..."
    # === ここが最大の変更点 ===
    # 手動でgit cloneやlnをする代わりに、この1行で全てを行います。
    # - SSH鍵がなくてもCloneできるようにHTTPS経由で行います。
    # - run_once_setup.sh.tmpl が自動で走るので、パッケージもインストールされます。
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Yutosaki

    echo "🎉 VM内セットアップ完了！"
EOF

# --- VMのIPアドレスを取得 ---
VM_IP=$(multipass info "$VM_NAME" | grep IPv4 | awk '{print $2}')

echo "✨ すべての作業が完了しました！"
echo "以下のコマンドでログインできます:"
echo ""
echo "🔹 Multipassシェルで接続:"
echo "   multipass shell $VM_NAME"
echo ""
echo "🔹 SSHで直接接続:"
echo "   ssh ubuntu@$VM_IP"
