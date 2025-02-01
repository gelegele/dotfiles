if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
# XDG for Vim. Suppress Neovim loads vimrc.
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/.vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
# XDG npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

#history
if [ ! -d $XDG_DATA_HOME/bash ]; then
  mkdir -p $XDG_DATA_HOME/bash
fi
HISTFILE=$XDG_DATA_HOME/bash/bash_history
HISTCONTROL=ignoredups
HISTIGNORE=hs:ll:cd

# Release ctrl + S and ctrl +q to be enabled to map.
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

#Source-hilight with less
export LESS='-R'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

alias ll='ls -AlFh --color=auto'
alias tm=tmux
alias v=nvim
alias vr='nvim -R'
alias f=vifm
alias hs=history
alias gr='grep --color=auto'
alias g=git
alias relogin='exec $SHELL -l'

# z dot
eval "$(zoxide init bash)"

#.bashrc.local
if [ -f .bashrc.local ]; then
  source .bashrc.local
fi

# Homebrew PATH exept Mac
if [ ! "$(uname)" == 'Darwin' ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Added by nvm installer
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Google Cloud SDK インストーラーによる自動追記
# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.bash.inc' ]; then . '~/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.bash.inc' ]; then . '~/google-cloud-sdk/completion.bash.inc'; fi

# customize prompt by starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init bash)"


# Java SDK Manager
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

