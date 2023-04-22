#!/bin/bash

sudo apt update -y
sudo apt install -y zsh

# Change default shell zsh.
chsh -s $(which zsh)

rm -rf ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o ~/.zsh/completion/_docker
curl -L https://raw.githubusercontent.com/docker/compose/v2.4.1/contrib/completion/zsh/_docker-compose -o ~/.zsh/completion/_docker-compose
