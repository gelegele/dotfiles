#!/usr/bin/env bash

echo "Installing nvm..."
brew install nvm

echo "Configure nvm..."
export NVM_DIR=~/.config/nvm
case $OSTYPE in
  darwin*)  #Mac
    [ -s /usr/local/opt/nvm/nvm.sh ] && . /usr/local/opt/nvm/nvm.sh
    [ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ] && . /usr/local/opt/nvm/etc/bash_completion.d/nvm
    ;;
  linux*)   #Linux
    [ -s /home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh ] && . /home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh 
    [ -s /home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm ] && . /home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm
    ;;
esac

