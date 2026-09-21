# .zshrc is loaded after ~/.zshenv loading.

# Comment in for zsh profiling
# zmodload zsh/zprof

# Lines configured by zsh-newuser-install
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history
if [[ -f $ZDOTDIR/zsh_history && ! -e $HISTFILE ]]; then
  mv -- "$ZDOTDIR/zsh_history" "$HISTFILE"
fi
HISTSIZE=10000
SAVEHIST=10000
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

# Prevent duplicated PATH / fpath
typeset -U path PATH fpath

# LANGは utf8 系にしたい（ll 表示順に影響）。日本語 UI にするなら ja_JP.UTF-8
case $OSTYPE in
  darwin*)  #Mac
    export LANG='UTF-8'
    ;;
  linux*)   #Linux
    export LANG=C.UTF-8
    ;;
esac

# Add brew PATH if Linux
if [[ $OSTYPE == linux* && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# Enabled completions after brew shellenv
if [[ -n $HOMEBREW_PREFIX ]]; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi
# zsh-completions must be on fpath before compinit (sheldon sources the rest later)
_zsh_completions_src="${XDG_DATA_HOME:-$HOME/.local/share}/sheldon/repos/github.com/zsh-users/zsh-completions/src"
[[ -d $_zsh_completions_src ]] && fpath=($_zsh_completions_src $fpath)
unset _zsh_completions_src
autoload -Uz compinit
# Rebuild dump only when missing or older than 24h; otherwise skip security scan (-C)
() {
  setopt local_options extended_glob
  local zdump=${ZDOTDIR:-$HOME}/.zcompdump
  if [[ -n $zdump(#qN.mh+24) ]]; then
    compinit -d $zdump
  else
    compinit -C -d $zdump
  fi
}

# for WSL.
if [[ "$(uname -r)" == *microsoft* ]]; then
  # To use system clipboard
  export PATH=$PATH:$XDG_CONFIG_HOME/win32yank
  # To use VS Code
  export PATH=$PATH:"/mnt/c/Users/${USERNAME}/AppData/Local/Programs/Microsoft VS Code/bin"
  export PATH=$PATH:"/mnt/c/Program Files/Microsoft VS Code/bin"
  # Change Windows folder ls color
  if [ ! -f $ZDOTDIR/.dircolors ]; then
    dircolors -p | sed 's/^OTHER_WRITABLE 34;42/OTHER_WRITABLE 01;34/' > $ZDOTDIR/.dircolors
  fi
  eval "$(dircolors -b $ZDOTDIR/.dircolors)"
  # Exclude unnecessary windows files from completions
  zstyle ':completion:*' ignored-patterns '*.dll' '*.sys' '*.exe' '*.mof' '*.msc' '*.cmd' '*.vbs' '*.efi'
fi

# Select a completion with TAB key or C-n/p
zstyle ':completion:*:default' menu select=1
zmodload zsh/complist
bindkey -M menuselect '^n' down-line-or-history
bindkey -M menuselect '^p' up-line-or-history
# aws cli completion
case $OSTYPE in
  darwin*)  #Mac
    autoload bashcompinit && bashcompinit
    complete -C '/usr/local/bin/aws_completer' aws
    ;;
  linux*)   #Linux
    source $HOMEBREW_PREFIX/share/zsh/site-functions/aws_zsh_completer.sh
    ;;
esac

# to comp ssh config name
if [ -f ~/.ssh/config ]; then
  function _ssh {
    compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
  }
fi

# history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

case $OSTYPE in
  darwin*)  #Mac
    #Source-hilight with less
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
    export LESS='-R'
    ;;
  linux*)   #Linux
    #Source-hilight with less
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    export LESS='-R'
    ;;
esac

# z dot
eval "$(zoxide init zsh)"

# fzf default options
export FZF_DEFAULT_OPTS="--layout=reverse --border --height 50% --inline-info"
# fzf preview with less
function fzp() {
  fzf --preview 'less {}'
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

# Go Settings
if type go &> /dev/null; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# alias
alias relogin='exec $SHELL -l'
if type eza &> /dev/null; then
  export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza
  alias ll='eza -alF --time-style=long-iso'
else
  alias ll='ls -alFh --time-style=long-iso --color=auto'
fi
if type bat &> /dev/null; then
  alias cat=bat
fi
alias gip='curl https://ifconfig.io'
alias du='du -h --total'
alias gr='grep --color=auto'
alias tm=tmux
alias tma='tmux a'
alias tmk='tmux kill-server'
alias vim='vim -Nu $XDG_CONFIG_HOME/vim/.vimrc'
alias v=nvim
alias vr='nvim -R'
alias cpinitlua='cp -f ~/.config/nvim/init.lua /mnt/c/Users/${USERNAME}/AppData/Local/nvim/init.lua'
alias g=git
alias gl=lazygit
alias apt-update='sudo apt update -y && sudo apt upgrade -y'
alias docker-start='sudo service docker start'
alias check-true-color='curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash'
alias show-256colors='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/gawin/bash-colors-256/master/colors)"'
alias rgh='rg --hidden'
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
  alias open='wsl-open'
  alias wslshutdown='/mnt/c/WINDOWS/system32/wsl.exe --shutdown'
  alias cdwin='cd /mnt/c/Users/'
fi

# Google search
function ggl() {
    local search_query="$@"
    local encoded_query=$(echo "$search_query" | sed 's/ /+/g')
    open "https://www.google.com/search?q=$encoded_query"
}

# yazi - File Manager
function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Plugin Manager Sheldon. The config file is ~/.config/sheldon/plugins.toml
eval "$(sheldon source)"

# color for zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#008080'

# nvm — lazy-load on first use
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
case $OSTYPE in
  darwin*)
    _NVM_SH="/usr/local/opt/nvm/nvm.sh"
    _NVM_COMPLETION="/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    ;;
  linux*)
    _NVM_SH="/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
    _NVM_COMPLETION="/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
    ;;
esac
_load_nvm() {
  unset -f nvm node npm npx _load_nvm
  [ -s "$_NVM_SH" ] && . "$_NVM_SH"
  [ -s "$_NVM_COMPLETION" ] && . "$_NVM_COMPLETION"
  unset _NVM_SH _NVM_COMPLETION
}
nvm()  { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm()  { _load_nvm; npm "$@"; }
npx()  { _load_nvm; npx "$@"; }

# sdkman — expose current candidates via PATH; full init only on `sdk`
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
if [[ -d $SDKMAN_DIR/candidates ]]; then
  for _sdk_bin in $SDKMAN_DIR/candidates/*/current/bin(N); do
    [[ -d $_sdk_bin ]] && path=("$_sdk_bin" $path)
  done
  unset _sdk_bin
fi
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# customize prompt by starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init zsh)"

# load .zshrc.local if it exists.
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local

# profile if zprof was loaded
if ( which zprof &> /dev/null ); then
  zprof
fi

