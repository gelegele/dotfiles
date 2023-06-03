#!/bin/bash

echo ''
echo 'Installing tmux ...'

sudo apt install tmux -y

$(dirname $0)/sub_mklink_config.sh tmux

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

