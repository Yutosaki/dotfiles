# ================================
# Bash 設定ファイル
# ================================
# コマンド補完の有効化
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# ================================
# 履歴設定
# ================================
export HISTSIZE=10000        # 保存する履歴の数
export HISTFILESIZE=20000    # 履歴ファイルのサイズ
shopt -s histappend          # 履歴を追記
PROMPT_COMMAND='history -a'  # セッション毎に追加

# ================================
# alias（ショートカット）設定
# ================================
alias ll='ls -al --color=auto'

# ================================
# PATH 設定
# ================================
export PATH="$HOME/bin:$PATH"

# ================================
# シンプルな関数定義
# ================================
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# ================================
# プロンプト設定
# ================================
# オレンジベースのプロンプト：シェル名とホスト名は同じ色 (208)
shellName=$(echo "$0" | sed 's/^-//')
parse_git_branch() {
    git branch 2>/dev/null | sed -n '/\* /s///p'
}

PS1="$(tput setaf 208)${shellName}$(tput setaf 220)@$(tput setaf 208)\h $(tput setaf 215)\w $(tput setaf 228)\$(parse_git_branch)$(tput sgr0)\$ "

# ================================
# その他の設定
# ================================
# vim をデフォルトエディタに設定
export EDITOR=vim

# ターミナルの動作を高速化する設定
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set bell-style none'

# Lima BEGIN
# Make sure iptables and mount.fuse3 are available
PATH="$PATH:/usr/sbin:/sbin"
export PATH
# Lima END

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
