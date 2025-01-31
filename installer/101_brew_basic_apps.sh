#!/usr/bin/env bash

# For Debian and Ubuntu
if type apt-get &> /dev/null; then
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y build-essential procps curl file git
  if  [ -e /etc/lsb-release ]; then
    sudo apt install -y language-pack-ja
  else
    sudo apt install -y locales
  fi 
fi

echo "Install Homebrew and set PATH temporary if Linux"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
case $OSTYPE in
  darwin*)  #Mac
    ;;
  linux*)   #Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
esac

echo "Installing basic apps..."
defaultpackages=(gcc wget tree unzip ripgrep fzf zoxide bat gh awscli)
if [[ "$(uname -r)" != *microsoft* ]]; then
  # not WSL
  defaultpackages+=(font-hackgen font-hackgen-nerd)
fi
brew install ${defaultpackages[@]}

