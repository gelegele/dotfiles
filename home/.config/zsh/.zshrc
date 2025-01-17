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

# Select a completion by TAB key
zstyle ':completion:*:default' menu select=1
autoload -Uz compinit && compinit

# LANGはutf8またはUTF-8にしたい（ll表示順に影響）。日本語にするなら ja_JP.UTF8
# Linuxのバージョンによってどっちが入ってるかわからないのでどっちも対応できるよう
export LANG=`locale -a | grep -i c.utf | grep 8`

# promptコマンド有効化
autoload -U promptinit
promptinit

# for WSL.
if [[ "$(uname -r)" == *microsoft* ]]; then
  # Change Windows folder ls color
  if [ ! -f $ZDOTDIR/.dircolors ]; then
    dircolors -p | sed 's/^OTHER_WRITABLE 34;42/OTHER_WRITABLE 01;34/' > $ZDOTDIR/.dircolors
  fi
  eval "$(dircolors -b $ZDOTDIR/.dircolors)"
  # Exclude unnecessary windows files from completions
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

# history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# Add brew PATH if Linux
case $OSTYPE in
  darwin*)  #Mac
    ;;
  linux*)   #Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
esac

# z dot
eval "$(zoxide init zsh)"

#Source-hilight with less
# TODO: add path for Mac
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

# Add PATH for GO LANG if go command exists.
if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# alias
alias relogin='exec $SHELL -l'
if command -v eza &> /dev/null; then
  export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza
  alias ll='eza -al --time-style=long-iso'
else
  alias ll='ls -alFh --time-style=long-iso --color=auto'
fi
alias cat=bat
alias gip='curl https://ifconfig.io'
alias du='du -h --total'
alias gr='grep --color=auto'
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
  alias e='explorer.exe .'
  alias wslshutdown='/mnt/c/WINDOWS/system32/wsl.exe --shutdown'
  alias fixdate='sudo hwclock -s|date'
  alias cdwin='cd /mnt/c/Users/'
  alias adlist='w32tm.exe /monitor'
fi

# aws cli completion
source $HOMEBREW_PREFIX/share/zsh/site-functions/aws_zsh_completer.sh
# TODO This is for Linux. Write for Mac.

# Plugin Manager Sheldon. The config file is ~/.config/sheldon/plugins.toml
eval "$(sheldon source)"

# color for zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#008080'

# for nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
case $OSTYPE in
  darwin*)  #Mac
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm 
    ;;
  linux*)   #Linux
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    ;;
esac
# Install the latest Node.js if not exists
if ! command -v node &> /dev/null; then
  source $XDG_CONFIG_HOME/nvm/nvm.sh
  nvm install node
fi

# customize prompt by starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init zsh)"

# load .zshrc.local if it exists.
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
