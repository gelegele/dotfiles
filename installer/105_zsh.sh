#!/bin/bash

echo ''
echo 'Install zsh ... '

sudo apt install -y zsh

$(dirname $0)/sub_mklink_config.sh zsh

# Install plugin manager
git clone --depth 1 https://github.com/zsh-users/antigen.git $HOME/.config/zsh/antigen/

mkdir -p ~/.config/zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o $HOME/.config/zsh/completion/_docker

echo 'Change default shell zsh.'
chsh -s $(which zsh)
