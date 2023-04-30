#!/bin/bash

echo ''
echo 'Install Neovim ...'

# telescope needs ripgrep
# appimage needs FUSE
sudo apt install -y ripgrep fuse

# Install appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
sudo chmod +x /usr/local/bin/nvim

