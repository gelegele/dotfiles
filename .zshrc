# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_find_no_dups
setopt hist_no_store
setopt share_history
setopt extended_history
setopt autocd
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# promptコマンド有効化
autoload -U promptinit
promptinit

# コマンド補完
fpath=(~/.zsh/completion $fpath)

# TABキーで補完候補から選択
zstyle ':completion:*:default' menu select=1
# 補完候補からWindows系の不要なファイルを除外
if [[ "$(uname -r)" == *microsoft* ]]; then
  zstyle ':completion:*' ignored-patterns '*.dll' '*.sys' '*.exe' '*.mof' '*.msc' '*.cmd' '*.vbs' '*.efi'
fi
# select comp list
zmodload zsh/complist
bindkey -M menuselect '^n' down-line-or-history               # 補完候補1つ下へ
bindkey -M menuselect '^p' up-line-or-history                 # 補完候補1つ上へ

# to comp ssh config name
function _ssh {
  compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}

# git settings
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
setopt PROMPT_SUBST ; PS1='%F{cyan}%n@%m%f %F{green}%~%f%F{red}$(__git_ps1 " (%s)")%f\$ '

# history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# 履歴からの補完
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# aws補完
export PATH=/usr/local/bin:$PATH
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# z hoge => cd /aaa/bb/hoge 
if [ -e ~/.z.d/z.sh ]; then
  _Z_DATA=~/.z.d/z.data
  source ~/.z.d/z.sh
fi

#Source-hilight with less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS='-R'
# edit function color to yellow from black in /usr/share/source-highlight/esc.style

# fzf default options
export FZF_DEFAULT_OPTS="--layout=reverse --border --height 50% --inline-info"
# fzf preview with less
function fzp() {
  fzf --preview 'less {}'
}
# fzf and vim
function fzv() {
  vim $(ls -ap1| grep -v / | fzp)
}

# mkdir and cd
function mkcd() {
  mkdir $1 && cd $1
}

# ctrl + S を無効化
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

#color ls
case "${OSTYPE}" in
darwin*)
  alias ll='ls -AlFh -G'
  alias llt='ls -AlFtr -G'
  ;;
*)
  alias ll='ls -AlFh --color=auto'
  alias llt='ls -AlFtr --color=auto'
  ;;
esac

alias ls='ls -CF'
alias osv='cat /etc/os-release'
alias shell='echo $0'
alias vir='vim -R '
alias gip='curl https://ifconfig.io'
alias du='du -h --total'
alias gr='grep --color=auto'
alias aptfzf="dpkg -l | sed -e '1,5d' | fzf"
if [ -e /usr/local/bin/ccat ]; then
  alias cat=ccat
fi
alias g=git
alias g_pull_master="git checkout master | git pull"
alias g_delete_merged_branches="git branch --merged | grep -v '*' | xargs -I % git branch -d %"
alias py=python3
alias python=python3
alias pip=pip3
alias ipython=ipython3
alias venv-create='python -m venv venv'
alias venv-activate='source ./venv/bin/activate'
alias venv-deactivate='deactivate'
alias vi='nvim'
alias nv='nvim .'
alias env-load='set -a && source .env && set +a'
alias gcloud-config-list='gcloud config configurations list'
alias gcloud-config-activate='gcloud config configurations activate'
alias docker-start='sudo service docker start'
alias check-true-color='curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash'
# for wsl2
if [[ "$(uname -r)" == *microsoft* ]]; then
  alias vs='code .'
  alias e='explorer.exe .'
  alias wslshutdown='/mnt/c/WINDOWS/system32/wsl.exe --shutdown'
  alias fixdate='sudo hwclock -s|date'
  alias cdwin='cd /mnt/c/Users/'
  alias adlist='w32tm.exe /monitor'
fi

# LANGはutf8またはUTF-8にしたい（ll表示順に影響）。日本語にするなら ja_JP.UTF8
# Linuxのバージョンによってどっちが入ってるかわからないのでどっちも対応できるよう
export LANG=`locale -a | grep -i c.utf | grep 8`

# ローカル設定読み込み
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
