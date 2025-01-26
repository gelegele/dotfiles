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

# Prevent duplicated PATH
typeset -U path PATH

# LANGはutf8またはUTF-8にしたい（ll表示順に影響）。日本語にするなら ja_JP.UTF8
# Linuxのバージョンによってどっちが入ってるかわからないのでどっちも対応できるよう
case $OSTYPE in
  darwin*)  #Mac
    export LANG='UTF-8'
    ;;
  linux*)   #Linux
    export LANG=`locale -a | grep -i c.utf | grep 8`
    ;;
esac

# Add brew PATH if Linux
if [[ $OSTYPE == "linux"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# Enabled completions after brew shellenv
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit

# for WSL.
if [[ "$(uname -r)" == *microsoft* ]]; then
  # To use system clipboard
  export PATH=$PATH:$XDG_CONFIG_HOME/win32yank
  # To use VS Code
  export PATH=$PATH:"/mnt/c/Users/${USERNAME}/AppData/Local/Programs/Microsoft VS Code/bin"
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

# Add PATH for GO LANG if go command exists.
if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# alias
alias relogin='exec $SHELL -l'
if command -v eza &> /dev/null; then
  export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza
  alias ll='eza -alF --time-style=long-iso'
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
