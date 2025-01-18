#!/usr/bin/env bash

if [[ "$(uname -r)" != *microsoft* ]]; then
  echo 'You are not on WSL. This is not necessary.'
  exit
fi

# Open url by Windows Browser.
npm install -g wsl-open
sudo ln -sf $(which wsl-open) /usr/local/bin/xdg-open

# TODO
Exclude windows files from completion
