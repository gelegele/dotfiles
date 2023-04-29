# .zshenv

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
# XDG Vim. But I don't want Neovim to load vimrc.
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/.vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
# XDG zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
