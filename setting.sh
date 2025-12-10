#!/bin/bash

# エラーが出たら停止する場合（お好みでコメントアウトを外してください）
# set -e

# dotfilesディレクトリのパス（このスクリプトがある場所を基準にする）
DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 セットアップを開始します..."

# --- 1. パッケージのインストール (fzf, lsd, batなど) ---
echo "📦 システムパッケージをインストール中..."
if [ "$(uname)" = "Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y lsd bat build-essential
    
    # Ubuntuのbatは 'batcat' という名前でインストールされることがあるため、エイリアスを設定
    if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
    fi

elif [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "🍺 Homebrewがインストールされていません。インストールしてください。"
        exit 1
    fi
    brew update
    brew install fzf lsd bat
else
    echo "❌ Unsupported OS"
    exit 1
fi

# --- 2. Rust (Cargo) のインストール ---
if ! command -v cargo &> /dev/null; then
    echo "🦀 Rust (cargo) をインストール中..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # インストール直後にパスを通す
    source "$HOME/.cargo/env"
else
    echo "✅ Rustは既にインストールされています。"
fi

# --- 3. Zshプラグイン等のクローン ---
# すでに存在する場合はクローンをスキップする関数
clone_if_not_exists() {
    REPO_URL=$1
    DEST_DIR=$2
    if [ ! -d "$DEST_DIR" ]; then
        echo "⬇️  Cloning $DEST_DIR..."
        git clone "$REPO_URL" "$DEST_DIR"
    else
        echo "✅ $DEST_DIR は既に存在します。"
    fi
}

echo "🔌 プラグインをダウンロード中..."
# dotfilesディレクトリ内に配置するもの
cd "$DOTFILES_DIR" || exit
clone_if_not_exists "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$DOTFILES_DIR/zsh-syntax-highlighting"
clone_if_not_exists "https://github.com/zsh-users/zsh-autosuggestions" "$DOTFILES_DIR/zsh-autosuggestions"
clone_if_not_exists "https://github.com/Aloxaf/fzf-tab" "$DOTFILES_DIR/fzf-tab"
clone_if_not_exists "https://github.com/sharkdp/bat.git" "$DOTFILES_DIR/bat"

# ホームディレクトリの隠しフォルダに配置するもの
clone_if_not_exists "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

# --- 4. fzfのセットアップ ---
echo "⚙️  fzfをセットアップ中..."
if [ -f "$HOME/.fzf/install" ]; then
    "$HOME/.fzf/install" --all --no-bash --no-fish  # zshのみ有効化、キーバインド等はyes
fi

# --- 5. batのビルド (ソースからビルドする場合) ---
# パッケージマネージャで入れたbatで十分な場合はこのセクションは不要ですが、
# リポジトリをCloneしているのでビルドする設定を残します。
if [ -d "$DOTFILES_DIR/bat" ] && command -v cargo &> /dev/null; then
    echo "🦇 batをソースからビルド中 (時間がかかる場合があります)..."
    (cd "$DOTFILES_DIR/bat" && cargo build --release)
    # ビルドしたバイナリを使うならパスを通すかリンクが必要
    # 例: sudo cp "$DOTFILES_DIR/bat/target/release/bat" /usr/local/bin/bat
fi


# --- 6. シンボリックリンクの作成 (ln -snf) ---
echo "🔗 設定ファイルのリンクを作成中..."

# ホームディレクトリ直下に置くファイル
ln -snf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -snf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -snf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -snf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -snf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# .config ディレクトリ内に置くもの (Neovimなど)
mkdir -p "$HOME/.config"
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Karabiner-Elements (Macのみ)
if [ "$(uname)" = "Darwin" ]; then
    mkdir -p "$HOME/.config/karabiner"
    ln -snf "$DOTFILES_DIR/karabiner-elements.json" "$HOME/.config/karabiner/karabiner.json"
fi

echo "✨ セットアップが完了しました！"
echo "ターミナルを再起動するか、'source ~/.zshrc' を実行してください。"
