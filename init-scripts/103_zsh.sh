#!/bin/bash

# Clean $ZDOTDIR specified by .zshenv
rm -rf $XDG_CONFIG_HOME/zsh
mkdir $XDG_CONFIG_HOME/zsh

git clone https://github.com/zsh-users/zsh-autosuggestions $XDG_CONFIG_HOME/zsh/zsh-autosuggestions

mkdir -p $XDG_CONFIG_HOME/zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o $XDG_CONFIG_HOME/zsh/completion/_docker

sudo apt install -y zsh

# Change default shell zsh.
chsh -s $(which zsh)
