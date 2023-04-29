#!/bin/bash

sudo apt install -y zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions

mkdir -p ~/.config/zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o $XDG_CONFIG_HOME/zsh/completion/_docker

# Change default shell zsh.
chsh -s $(which zsh)
