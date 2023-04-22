#!/bin/bash

# Install nvm to manage node versions.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Install LTS node by nvm.
nvm install --lts

# npm is installed by nvm. You should update it.
npm update -g npm
