#!/bin/bash

sudo apt install gh

# If wsl, you need wsl-open for gh browse.
if [[ "$(uname -r)" == *microsoft* ]]; then
  npm install -g wsl-open
  sudo ln -s $(which wsl-open) /usr/local/bin/xdg-open
fi
