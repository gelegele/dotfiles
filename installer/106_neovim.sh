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

