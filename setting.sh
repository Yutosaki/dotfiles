#!/bin/bash

# エラーが出たら停止する場合（お好みでコメントアウトを外してください）
# set -e

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 セットアップを開始します..."

# --- 1. パッケージのインストール ---
echo "📦 システムパッケージをインストール中..."
if [ "$(uname)" = "Linux" ]; then
    sudo apt-get update
    
    # apt版の古いfzfを削除
    if dpkg -l | grep -q fzf; then
        echo "🗑️  古い (apt版) fzf を削除中..."
        sudo apt-get remove -y fzf
    fi

    sudo apt-get install -y lsd bat build-essential unzip valgrind
    
    if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
    fi

elif [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "🍺 Homebrewがインストールされていません。"
        exit 1
    fi
    brew update
    brew install lsd bat valgrind
else
    echo "❌ Unsupported OS"
    exit 1
fi

# --- 2. Rust (Cargo) のインストール ---
if ! command -v cargo &> /dev/null; then
    echo "🦀 Rust (cargo) をインストール中..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "✅ Rustは既にインストールされています。"
fi

# --- 3. プラグイン等のクローン ---
clone_if_not_exists() {
    REPO_URL=$1
    DEST_DIR=$2
    if [ ! -d "$DEST_DIR" ]; then
        echo "⬇️  Cloning $DEST_DIR..."
        git clone --depth 1 "$REPO_URL" "$DEST_DIR"
    else
        echo "✅ $DEST_DIR は既に存在します。"
    fi
}

echo "🔌 プラグインをダウンロード中..."
cd "$DOTFILES_DIR" || exit

clone_if_not_exists "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$DOTFILES_DIR/zsh-syntax-highlighting"
clone_if_not_exists "https://github.com/zsh-users/zsh-autosuggestions" "$DOTFILES_DIR/zsh-autosuggestions"
clone_if_not_exists "https://github.com/Aloxaf/fzf-tab" "$DOTFILES_DIR/fzf-tab"
clone_if_not_exists "https://github.com/sharkdp/bat.git" "$DOTFILES_DIR/bat"
clone_if_not_exists "https://github.com/junegunn/fzf.git" "$DOTFILES_DIR/fzf"

# --- 4. fzfのセットアップ ---
echo "⚙️  fzfをセットアップ中..."

if [ -f "$DOTFILES_DIR/fzf/install" ]; then
    # dotfiles内のインストーラーを実行
    "$DOTFILES_DIR/fzf/install" --all --no-bash --no-fish
    
    # システムパス (/usr/local/bin) にシンボリックリンクを作成
    if [ "$(uname)" = "Linux" ]; then
        echo "🔗 fzfへのパスを通しています..."
        sudo ln -sf "$DOTFILES_DIR/fzf/bin/fzf" /usr/local/bin/fzf
    fi
fi

# --- 5. batのビルド ---
if [ -d "$DOTFILES_DIR/bat" ] && command -v cargo &> /dev/null; then
    echo "🦇 batをソースからビルド中..."
    (cd "$DOTFILES_DIR/bat" && cargo build --release)
fi

# --- 6. シンボリックリンクの作成 ---
echo "🔗 設定ファイルのリンクを作成中..."

mkdir -p "$HOME/.config"

ln -snf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -snf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -snf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -snf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -snf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

if [ "$(uname)" = "Darwin" ]; then
    mkdir -p "$HOME/.config/karabiner"
    ln -snf "$DOTFILES_DIR/karabiner-elements.json" "$HOME/.config/karabiner/karabiner.json"
fi

echo "✨ セットアップが完了しました！"
