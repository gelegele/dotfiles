#!/bin/bash

rm -rf ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o ~/.zsh/completion/_docker
curl -L https://raw.githubusercontent.com/docker/compose/v2.4.1/contrib/completion/zsh/_docker-compose -o ~/.zsh/completion/_docker-compose
# .zshrc にて fpath=(~/.zsh/completion $fpath) 
