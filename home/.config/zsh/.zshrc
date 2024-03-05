# .zshrc is loaded after ~/.zshenv loading.

# Lines configured by zsh-newuser-install
HISTFILE=$ZDOTDIR/zsh_history
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
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# LANGはutf8またはUTF-8にしたい（ll表示順に影響）。日本語にするなら ja_JP.UTF8
# Linuxのバージョンによってどっちが入ってるかわからないのでどっちも対応できるよう
export LANG=`locale -a | grep -i c.utf | grep 8`

# promptコマンド有効化
autoload -U promptinit
promptinit

# Change Windows folder ls color for WSL.
if [[ "$(uname -r)" == *microsoft* ]]; then
  if [ ! -f $ZDOTDIR/.dircolors ]; then
    dircolors -p | sed 's/^OTHER_WRITABLE 34;42/OTHER_WRITABLE 01;34/' > $ZDOTDIR/.dircolors
  fi
  eval "$(dircolors -b $ZDOTDIR/.dircolors)"
fi

# コマンド補完
fpath=($ZDOTDIR/completion $fpath)

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
source $XDG_CONFIG_HOME/git/prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
setopt PROMPT_SUBST ; PS1='%F{cyan}%n@%m%f %F{green}%~%f%F{red}$(__git_ps1 " (%s)")%f\$ '

# history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# z dot
eval "$(zoxide init zsh)"

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

# Release ctrl + S and ctrl +q to be enabled to map.
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

alias ll='ls -AlFh --time-style=long-iso --color=auto'
alias gip='curl https://ifconfig.io'
alias du='du -h --total'
alias gr='grep --color=auto'
if [ -e /usr/local/bin/ccat ]; then
  alias cat=ccat
fi
alias tm=tmux
alias tma='tmux a'
alias tmk='tmux kill-server'
alias vim='vim -Nu $XDG_CONFIG_HOME/vim/.vimrc'
alias v=nvim
alias vr='nvim -R'
alias f=vifm
alias g=git
alias gl=lazygit
alias docker-start='sudo service docker start'
alias check-true-color='curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash'
alias show-256colors='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/gawin/bash-colors-256/master/colors)"'
alias aptfzf="dpkg -l | sed -e '1,5d' | fzf"
alias py=python3
alias python=python3
alias pip=pip3
alias venv-create='python -m venv venv'
alias venv-activate='source ./venv/bin/activate'
alias venv-deactivate='deactivate'
alias env-load='set -a && source .env && set +a'
alias gcloud-config-list='gcloud config configurations list'
alias gcloud-config-activate='gcloud config configurations activate'
# for wsl2
if [[ "$(uname -r)" == *microsoft* ]]; then
  alias vs='code .'
  alias e='explorer.exe .'
  alias wslshutdown='/mnt/c/WINDOWS/system32/wsl.exe --shutdown'
  alias fixdate='sudo hwclock -s|date'
  alias cdwin='cd /mnt/c/Users/'
  alias adlist='w32tm.exe /monitor'
fi

# Plugin Manager
source $ZDOTDIR/antigen/antigen.zsh
# <-- My plugins --
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# auto complete
antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#008080'
# - for aws
export PATH=/usr/local/bin:$PATH
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
# Tell Antigen that you're done.
antigen apply
# -- My plugins -->

# Added by nvm installer
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# load .zshrc.local if it exists.
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
