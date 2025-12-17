# ================================
# Zsh 設定
# ================================

# 高機能な補完機能を有効化
autoload -Uz compinit && compinit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ヒストリ設定
setopt share_history         # 他のzshセッションと履歴を共有
setopt hist_ignore_space     # スペースから始まるコマンドは履歴に保存しない
setopt hist_reduce_blanks    # 余分なスペースを削除して履歴に保存
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# manでの表示をbatにする
export MANPAGER="sh -c 'col -bx | $HOME/dotfiles/bat/target/release/bat --theme=TwoDark --paging=always -l man -p'"

# batの色を設定
export BAT_THEME="Dracula"

# cdした後にlsするhook
chpwd() {
    if [[ $(pwd) != $HOME ]]; then
        lsd --icon=never
    fi
}

# ================================
# パス設定
# ================================
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.local/bin/flutter/bin"
export PATH="$PATH:$HOME/opt/anaconda3/bin/conda"
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="$PATH:$HOME/.config/nvim"
export PATH="$PATH:$HOME/dotfiles/nvim-os/nvim-macos-arm64/bin"
export PATH="$PATH:$HOME/dotfiles/nvim-os/nvim-linux-arm64/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
export PATH="$PATH:/opt/homebrew/opt/libpq/bin"
export PATH="$PATH:/opt/homebrew/opt/icu4c/bin"
export PATH="$PATH:/opt/homebrew/opt/icu4c/sbin"

export GOPATH="$HOME/Go"

export MANPATH="$MANPATH:/usr/share/man"
export MANPATH="$MANPATH:/usr/local/share/man"
export MANPATH="$MANPATH:/Library/TeX/texbin/man/man1"
export MANPATH="$MANPATH:/Library/TeX/texbin/man/man3"

# Lima 環境のためのパス追加
export PATH="$PATH:/usr/sbin:/sbin"

# cargoのpathを環境変数に設定
source ~/.cargo/env

# ================================
# PostgreSQL 設定
# ================================
export PATH="/usr/local/pgsql/bin:$PATH"
export LDFLAGS="-L/usr/local/pgsql/lib"
export CPPFLAGS="-I/usr/local/pgsql/include"
export PKG_CONFIG_PATH="/usr/local/pgsql/lib/pkgconfig:$PKG_CONFIG_PATH"
export LIBRARY_PATH="/usr/local/pgsql/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/pgsql/lib:$LD_LIBRARY_PATH"

# ICU4C 設定
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"

# ================================
# プロンプト設定
# ================================
autoload -Uz colors && colors
autoload -Uz vcs_info

# プロンプト内で変数を展開・コマンド置換を行うための設定
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{228}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{176}+"
zstyle ':vcs_info:*' formats "%F{121}%b%f%c%u"
zstyle ':vcs_info:*' actionformats '%F{red}%b|%a%f%c%u'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' disable-patterns ''

# コマンド実行前に毎回呼ばれる関数
precmd() {
    # vcs_info を実行して情報を更新
    vcs_info

    # シェル名を取得 (例: zsh)
    local shellName=$(ps -p $$ -o comm= | tr -d '-')
    
    # OS判定
    local os=$(uname)
    
    # OSごとの色設定
    local color_user
    local color_at
    local color_host
    local color_path
    
    if [ "$os" = "Darwin" ]; then
        # Mac用カラー (紫系)
        color_user="141"
        color_at="091"
        color_host="141"
        color_path="212"
    else
        # Linux用カラー (緑/青系)
        color_user="050"
        color_at="075"
        color_host="050"
        color_path="212"
    fi

    # プロンプトの構築
    # 1. ユーザー名@ホスト名
    local p_user_host="%F{${color_user}}${shellName}%F{${color_at}}@%F{${color_host}}%m"
    
    # 2. カレントディレクトリ (~/...)
    local p_dir="%F{${color_path}}%~"
    
    # 3. Git情報 (vcs_infoで取得した文字列)
    local p_git='${vcs_info_msg_0_}'
    
    # 4. プロンプト記号
    local p_symbol="%F{reset}$%f"

    # 結合して設定
    PROMPT="${p_user_host} ${p_dir} ${p_git} ${p_symbol} "
}

# ================================
# fzf 設定
# ================================
if [[ -f "$HOME/dotfiles/fzf/shell/key-bindings.zsh" ]]; then
    source "$HOME/dotfiles/fzf/shell/key-bindings.zsh"
fi

# fzfの設定
export FZF_DEFAULT_COMMAND='history -1000'
export FZF_CTRL_R_OPTS='--height 40% --layout=reverse --preview "echo {}" --preview-window down:3:wrap --bind ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
# fzf --preview 'bat --color=always --style=numbers --line-range=:50{}'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ctrl+Rでfzfを使用して履歴を検索
# 既存の key-bindings は使わず、独自ウィジェットを利用
__fzf_history__() {
  local history_cmd
  if [[ "$OSTYPE" == "darwin"* ]]; then
    history_cmd='history 1 | tail -r'
  else
    history_cmd='history 1 | tac'
  fi

  local selected
  selected=$(eval "$history_cmd" | fzf --height=40% --layout=reverse \
    --color="fg:#d0d0d0,bg:#1e1e1e,hl:#ffaf00,fg+:#d0d0d0,bg+:#5f00af,hl+:#ffaf00,info:#ffaf00,prompt:#ffaf00,pointer:#ffaf00,marker:#ffaf00,spinner:#ffaf00,header:#ffaf00" \
    --bind "del:abort")
  if [[ -n "$selected" ]]; then
     # Remove the history number using extended regex
    LBUFFER=$(echo "$selected" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//')
  fi
  zle redisplay
}

zle -N __fzf_history__
bindkey '^R' __fzf_history__

# fzf-tab の設定
fpath+=($HOME/dotfiles/fzf-tab) # fpath に fzf-tab を追加
source $HOME/dotfiles/fzf-tab/fzf-tab.plugin.zsh

# fzf-tab の詳細設定
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu yes select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=fg:135,fg+:206,hl:223,hl+:220 --bind=tab:accept
zstyle ':fzf-tab:*' fzf-preview-window 'up:40%,min-height:5'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --icon=never --tree --color=always $realpath'

# compinit の遅延対策
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="$HOME/.zcompdump"
fi
compinit -d "$ZSH_COMPDUMP"

# ================================
# SSH 設定
# ================================
eval "$(ssh-agent -s)"
export APPLE_SSH_ADD_BEHAVIOR=Apple

if [ "$(uname)" = "Darwin" ]; then
    if [ ! -f ~/.ssh/config.Darwin ]; then
        echo 'Match exec "test $(uname) = '\''Darwin'\''"' > ~/.ssh/config.Darwin
        echo '    UseKeychain yes' >> ~/.ssh/config.Darwin
    fi
else
    if [ ! -f ~/.ssh/config.Linux ]; then
        echo '# Linux 専用の設定' > ~/.ssh/config.Linux
    fi
fi

# ================================
# シェル拡張
# ================================
source ~/dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey '^L' autosuggest-accept

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ================================
# エイリアス
# ================================
alias francinette="$HOME/francinette/tester.sh"
alias paco="$HOME/francinette/tester.sh"
alias ls="lsd --icon never"
alias ll="ls -al"
alias bat='~/dotfiles/bat/target/release/bat'
alias tmp="cd /tmp"
alias tm="tmux"
alias mp="multipass"

m() {
  if [ "$(uname)" = "Darwin" ]; then
    command man "$@" #| eval "$MANPAGER"
  else
    command man --no-hyphenation --no-justification "$@" | eval "$MANPAGER"
  fi
}
alias man='m'

if command -v tac >/dev/null 2>&1; then
  alias rtac='tac'
else
  alias rtac='tail -r'
fi

# Google検索の関数
google(){
    local url="https://google.co.jp/search?q=${*// /+}"
    open -a "Google Chrome" "$url"
}

# Lima BEGIN
# Make sure iptables and mount.fuse3 are available
PATH="$PATH:/usr/sbin:/sbin"
export PATH
# Lima END


# .brewconfig.zsh が存在する場合のみ読み込む
if [ -f "$HOME/.brewconfig.zsh" ]; then
    source "$HOME/.brewconfig.zsh"
fi
