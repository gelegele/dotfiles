#!/usr/bin/env bash

defaultpackages=(gcc wget htop tree zip unzip ripgrep fzf zoxide bat nvm gh awscli)
if [[ "$(uname -r)" != *microsoft* ]]; then
  # not WSL
  defaultpackages+=(font-hackgen font-hackgen-nerd)
fi

echo "Install $defaultpackages"
brew install ${defaultpackages[@]}

