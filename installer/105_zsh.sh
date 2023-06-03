#!/bin/bash

echo ''
echo 'Install zsh ... '

sudo apt install -y zsh

$(dirname $0)/sub_mklink_config.sh zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions

mkdir -p ~/.config/zsh/completion
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o $XDG_CONFIG_HOME/zsh/completion/_docker

echo 'Change default shell zsh.'
chsh -s $(which zsh)
