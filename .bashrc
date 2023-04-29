if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# config files path
export XDG_CONFIG_HOME=$HOME/.config

#history
HISTCONTROL=ignoredups
HISTIGNORE=hs:ll:cd

#vi keybind
# set -o vi

# git settings
source $XDG_CONFIG_HOME/git/prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
# export PS1='\h\[\033[00m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
export PS1='\[\e[36m\]\h\[\e[00m\]:\[\e[32m\]\w\[\e[31m\]$(__git_ps1)\[\e[00m\]\$ '

#Source-hilight with less
export LESS='-R'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

#color ls
case "${OSTYPE}" in
darwin*)
  alias ll='ls -alF -G'
  ;;
*)
  alias ll='ls -alF --color=auto'
  ;;
esac

alias ls='ls -CF'
alias osv='cat /etc/os-release'
alias hs=history
alias shell='echo $0'
alias gr='grep --color=auto'
alias g=git
alias g_delete_merged_branches="git branch --merged | grep -v '*' | xargs -I % git branch -d %"
alias venv-activate='source ./venv/bin/activate'
alias vs='code .'

#.bashrc.local
if [ -f .bashrc.local ]; then
  source .bashrc.local
fi

# Added by nvm installer
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Google Cloud SDK インストーラーによる自動追記
# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.bash.inc' ]; then . '~/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.bash.inc' ]; then . '~/google-cloud-sdk/completion.bash.inc'; fi
