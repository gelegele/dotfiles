#!/usr/bin/env bash

if [[ "$(uname -r)" != *microsoft* ]]; then
  echo 'You are not on WSL. No need this.'
  exit
fi

npm install -g wsl-open
sudo ln -sf $(which wsl-open) /usr/local/bin/xdg-open

