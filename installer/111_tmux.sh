#!/bin/bash

echo ''
echo 'Installing tmux ...'

sudo apt install tmux -y

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

