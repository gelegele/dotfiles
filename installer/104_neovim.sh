#!/usr/bin/env bash

echo ''
echo 'Install Neovim ...'

brew install neovim

# config
$(dirname $0)/sub_mklink_config.sh nvim

# local config file to save colorscheme by Themery.
NVIM_LUA_DIR=~/.config/nvim/lua
rm -rf $NVIM_LUA_DIR
mkdir $NVIM_LUA_DIR
cat << EOT >> $NVIM_LUA_DIR/theme.lua
-- Themery block
  -- This block will be replaced by Themery.
-- end themery block
EOT

