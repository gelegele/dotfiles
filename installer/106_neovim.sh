#!/bin/bash

echo ''
echo 'Install Neovim ...'

# appimage needs FUSE
# telescope needs ripgrep and fd
sudo apt install -y fuse ripgrep fd-find

# Install appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
sudo chmod +x /usr/local/bin/nvim

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
