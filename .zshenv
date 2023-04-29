# .zshenv

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
# XDG Vim. But I don't want Neovim to load vimrc.
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/.vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
# XDG zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
# XDG npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
