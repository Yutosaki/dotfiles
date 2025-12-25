#!/bin/bash

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

# 実行ユーザーがrootかどうか判定
SUDO_CMD=""
if [ "$(id -u)" -ne 0 ]; then
    SUDO_CMD="sudo"
fi

echo "🚀 セットアップを開始します..."

# --- 1. システムパッケージ & 必須ツール ---
echo "📦 システムパッケージをインストール中..."

if [ "$(uname)" = "Linux" ]; then
    $SUDO_CMD apt-get update

    echo "🔨 必須ツールをインストール..."
    $SUDO_CMD apt-get install -y \
        build-essential unzip valgrind git curl zsh tmux

    # ユーティリティ (ripgrep, bat, lsd)
    $SUDO_CMD apt-get install -y ripgrep || echo "⚠️ ripgrep missing in apt (will use cargo)"
    $SUDO_CMD apt-get install -y bat || echo "⚠️ bat missing in apt (will use cargo)"
    $SUDO_CMD apt-get install -y lsd || echo "⚠️ lsd missing in apt (will use cargo)"

    # batcatリンク (Ubuntu対応)
    if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
        export PATH="$HOME/.local/bin:$PATH"
    fi

elif [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "🍺 Homebrew not found. Exiting."
        exit 1
    fi
    brew update
    brew install lsd bat ripgrep tmux
else
    echo "❌ Unsupported OS"
    exit 1
fi

# --- 2. Rust (Cargo) ---
if ! command -v cargo &> /dev/null; then
    echo "🦀 Rustをインストール中..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# --- 3. 不足ツールのCargoインストール ---
if ! command -v rg &> /dev/null; then cargo install ripgrep; fi
if ! command -v lsd &> /dev/null; then cargo install lsd; fi
if ! command -v bat &> /dev/null; then cargo install bat; fi

# --- 4. Neovim 本体のインストール ---
if ! command -v nvim &> /dev/null; then
    echo "🌑 Neovimをインストール中..."
    if [ "$(uname)" = "Linux" ]; then
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
        $SUDO_CMD rm -rf /opt/nvim
        $SUDO_CMD tar -C /opt -xzf nvim-linux64.tar.gz
        $SUDO_CMD ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
        rm nvim-linux64.tar.gz
    elif [ "$(uname)" = "Darwin" ]; then
        brew install neovim
    fi
fi

# --- 5. Dotfilesのリンク ---
echo "🔗 設定ファイルのリンクを作成中..."

mkdir -p "$HOME/.config"

ln -snf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -snf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -snf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -snf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

if [ "$(uname)" = "Darwin" ]; then
    mkdir -p "$HOME/.config/karabiner"
    ln -snf "$DOTFILES_DIR/karabiner-elements.json" "$HOME/.config/karabiner/karabiner.json"
fi

# --- 6. Zshプラグイン ---
clone_if_not_exists() {
    REPO_URL=$1; DEST_DIR=$2
    if [ ! -d "$DEST_DIR" ]; then git clone --depth 1 "$REPO_URL" "$DEST_DIR"; fi
}
mkdir -p "$DOTFILES_DIR"
clone_if_not_exists "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$DOTFILES_DIR/zsh-syntax-highlighting"
clone_if_not_exists "https://github.com/zsh-users/zsh-autosuggestions" "$DOTFILES_DIR/zsh-autosuggestions"
clone_if_not_exists "https://github.com/Aloxaf/fzf-tab" "$DOTFILES_DIR/fzf-tab"
clone_if_not_exists "https://github.com/junegunn/fzf.git" "$DOTFILES_DIR/fzf"

# --- 7. fzfセットアップ ---
if [ -f "$DOTFILES_DIR/fzf/install" ]; then
    "$DOTFILES_DIR/fzf/install" --all --no-bash --no-fish
    if [ "$(uname)" = "Linux" ]; then
        $SUDO_CMD ln -sf "$DOTFILES_DIR/fzf/bin/fzf" /usr/local/bin/fzf
    fi
fi

# --- 8. デフォルトシェル変更 ---
ZSH_PATH=$(which zsh)
if [ -n "$ZSH_PATH" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
    echo "🔄 デフォルトシェルをzshに変更..."
    chsh -s "$ZSH_PATH" || echo "⚠️ 手動で実行してください: chsh -s $(which zsh)"
fi

echo "✨ セットアップ完了！"
