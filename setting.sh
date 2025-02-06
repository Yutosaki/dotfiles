#/bin/sh

# fzf インストールスクリプト
if [ "$(uname)" = "Linux" ]; then
    sudo apt-get update
    sudo apt-get install fzf
elif [ "$(uname)" = "Darwin" ]; then
    brew update
    brew install fzf
else
    echo "Unsupported OS"
    exit 1
fi

# 必要なリポジトリをクローン
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# fzfを有効化
yes | ~/.fzf/install
