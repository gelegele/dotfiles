#!/usr/bin/env bash

defaultpackages=(gcc wget source-highlight tree unzip ripgrep fzf zoxide bat nvm gh awscli)
echo "Install $defaultpackages"
brew install ${defaultpackages[@]}

