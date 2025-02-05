export PATH="/usr/local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:$HOME/.venv/bin"
export GOPATH="$HOME/Go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin/flutter/bin"
export PATH="$PATH:$HOME/opt/anaconda3/bin/conda"
# export PYTHONPATH="/Users/sasakiyuto/.pyenv/versions/3.11.4/lib/python3.11/site-packages:$PYTHONPATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

eval "$(ssh-agent -s)"
export APPLE_SSH_ADD_BEHAVIOR=Apple
ssh-add --apple-use-keychain ~/.ssh/my-ssh-key
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# PostgreSQL 14 settings
export PATH="/usr/local/pgsql/bin:$PATH"
export LDFLAGS="-L/usr/local/pgsql/lib"
export CPPFLAGS="-I/usr/local/pgsql/include"
export PKG_CONFIG_PATH="/usr/local/pgsql/lib/pkgconfig:$PKG_CONFIG_PATH"
export LIBRARY_PATH="/usr/local/pgsql/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/pgsql/lib:$LD_LIBRARY_PATH"

export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PKG_CONFIG_PATH="/usr/local/pgsql/lib/pkgconfig:/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias francinette=/Users/sasakiyuto/francinette/tester.sh
alias paco=/Users/sasakiyuto/francinette/tester.sh
alias ls="lsd --icon never"
alias ls --tree="lsd --icon never --tree"
alias ll="ls -al"

google(){
     local url="https://google.co.jp/search?q=${*// /+}"
     open -a "Google Chrome" "$url"
}

