#!/bin/bash

if [[ $SHELL != *zsh ]]; then
  echo "Error: You should use zsh instead of ${SHELL}."
  exit 1
fi

if [[ -z $XDG_CONFIG_HOME && -z $XDG_DATA_HOME && -z $XDG_CACHE_HOME ]]; then
  echo "Error: You have to set XDG_CONFIG_HOME, XDG_DATA_HOME and XDG_CACHE_HOME."
  exit 1
fi

# Install nvm to manage node versions.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

echo 'nvm was installed.'
echo 'Logout your terminal and execute installer/201_npm_install.sh'
