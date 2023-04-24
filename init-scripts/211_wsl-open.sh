#!/bin/bash

if [[ "$(uname -r)" != *microsoft* ]]; then
  echo 'You are not on WSL. No need this.'
  exit
fi

sudo npm install -g wsl-open
sudo ln -s $(which wsl-open) /usr/local/bin/xdg-open
