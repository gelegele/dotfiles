#!/usr/bin/env bash

defaultpackages=(gcc wget source-highlight tree unzip fzf zoxide bat gh awscli)
echo "Install $defaultpackages"
brew install ${defaultpackages[@]}

