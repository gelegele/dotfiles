#!/bin/bash

# appimageにFUSEが必要
sudo apt install -y fuse

# インストール
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
sudo chmod +x /usr/local/bin/nvim

# 設定ファイル
mkdir -p ~/.config/nvim/
topdir=$(cd $(dirname $0)/..;pwd)
ln -sb $topdir/.config/nvim/init.lua ~/.config/nvim/init.lua  
