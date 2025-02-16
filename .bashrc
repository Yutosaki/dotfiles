# 色付きのプロンプト
PS1='\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] '

# コマンド補完を強化する
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# コマンド履歴を拡張する
export HISTSIZE=10000      # 保存する履歴の数
export HISTFILESIZE=20000  # 履歴ファイルのサイズ
shopt -s histappend        # 履歴を追記する
PROMPT_COMMAND='history -a'

# alias（短縮コマンド）を設定する
alias ll='ls -al --color=auto'

# PATHを追加する
export PATH="$HOME/bin:$PATH"

# シンプルで便利な関数
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Gitブランチをプロンプトに表示する
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}

PS1="$(tput setaf 208)\u$(tput setaf 220)@$(tput setaf 208)\h $(tput setaf 215)\w $(tput setaf 209)\$(parse_git_branch)$(tput sgr0) \$ "

# vimをデフォルトエディタに設定する
export EDITOR=vim

# ターミナルの動作を高速化する
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set bell-style none'

