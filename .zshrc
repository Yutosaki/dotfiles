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
export MANPAGER="sh -c 'col -bx | $HOME/dotfiles/bat/target/release/bat --theme=TwoDark -l man -p'"

# batの色を設定
export BAT_THEME="Dracula"

# ================================
# パス設定
# ================================
export PATH="/usr/local/bin:$PATH"
export GOPATH="$HOME/Go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.local/bin/flutter/bin"
export PATH="$PATH:$HOME/opt/anaconda3/bin/conda"
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"

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
parse_git_branch() {
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -n $branch ]] && echo " %F{221}$branch%f"
}

precmd() {
#  PROMPT="%F{141}%n%F{091}@%F{141}%m %F{212}%~$(parse_git_branch) %F{reset}%# "
  PROMPT="%F{050}%n%F{075}@%F{050}%m %F{212}%~$(parse_git_branch) %F{reset}%# "
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

# ================================
# シェル拡張
# ================================
source ~/dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ================================
# エイリアス
# ================================
alias francinette="$HOME/francinette/tester.sh"
alias paco="$HOME/francinette/tester.sh"
alias ls="lsd --icon never"
alias ll="ls -al"
alias bat='~/dotfiles/bat/target/release/bat'

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

