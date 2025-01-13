#!/usr/bin/env bash

# defaultpackages=(less curl wget ssh source-highlight tree unzip fzf zoxide bat python3-pip neofetch golang-go language-pack-ja build-essential)
defaultpackages=(wget wezterm source-highlight tree unzip fzf zoxide bat golang gh awscli)
echo "Install $defaultpackages"
brew install ${defaultpackages[@]}

