#!/bin/bash

if [[ $0 != -zsh ]]; then
  echo "Error: You should use zsh."
  exit 1
fi

if [[ -z $XDG_CONFIG_HOME ]]; then
  echo "Error: You have to set XDG_CONFIG_HOME."
  exit 1
fi

# Install nvm to manage node versions.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Install LTS node by nvm.
nvm install --lts

# npm is installed by nvm. You should update it.
npm update -g npm
