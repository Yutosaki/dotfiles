#!/bin/bash

# --- 設定項目 ---
VM_NAME="dev"
CPU="2"
MEM="4G"
DISK="10G"
INIT_YAML="$HOME/dotfiles/multipass/init.yaml"

echo "🚀 Multipass VM自動構築を開始します..."

# 1. 既存のVMがあれば削除
if multipass list | grep -q "$VM_NAME"; then
    echo "🗑️  既存のVM ($VM_NAME) を削除しています..."
    multipass delete "$VM_NAME"
    multipass purge
fi

# 2. VMを起動
echo "vm launching..."
multipass launch --name "$VM_NAME" --cpus "$CPU" --memory "$MEM" --disk "$DISK" --cloud-init "$INIT_YAML"

if [ $? -ne 0 ]; then
    echo "❌ VMの起動に失敗しました。init.yamlを確認してください。"
    exit 1
fi

echo "✅ VMが起動しました。セットアップコマンドを送信します..."

# 3. VM内部でセットアップコマンドを実行
multipass exec "$VM_NAME" -- bash << 'EOF'
    set -e  # エラーが出たら即停止

    echo "📦 パッケージをインストール中..."
    sudo apt update
    sudo apt install -y zsh tmux git neovim build-essential ripgrep fd-find curl unzip

    echo "🔑 DotfilesをClone中..."
    rm -rf /home/ubuntu/dotfiles
    git clone git@github.com:Yutosaki/dotfiles.git /home/ubuntu/dotfiles

    cd /home/ubuntu/dotfiles
    echo "📂 dotfilesディレクトリに移動しました: $(pwd)"

    echo "🔗 シンボリックリンク (ln -snf) を作成中..."
    mkdir -p /home/ubuntu/.config

    # --- リンク設定 ---
    ln -snf /home/ubuntu/dotfiles/.zshrc /home/ubuntu/.zshrc
    ln -snf /home/ubuntu/dotfiles/.bashrc /home/ubuntu/.bashrc
    ln -snf /home/ubuntu/dotfiles/.vimrc /home/ubuntu/.vimrc
    ln -snf /home/ubuntu/dotfiles/.gitconfig /home/ubuntu/.gitconfig
    ln -snf /home/ubuntu/dotfiles/.tmux.conf /home/ubuntu/.tmux.conf
    ln -snf /home/ubuntu/dotfiles/nvim /home/ubuntu/.config/nvim
    
    # setting.sh も実行権限をつけておく
    chmod +x setting.sh

    echo "⚙️  設定スクリプト (setting.sh) を実行中..."
    ./setting.sh

    echo "🐚 デフォルトシェルをzshに強制変更..."
    # chsh ではなく usermod を使うことで確実に変更します
    sudo usermod -s $(which zsh) ubuntu

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
