# .zshenv

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
# XDG zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
# XDG npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# If the system wrote something here, it's better to move it to .zshenv.local.
[ -s ~/.zshenv.local ] && source ~/.zshenv.local
