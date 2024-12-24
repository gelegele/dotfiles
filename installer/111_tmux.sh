#!/bin/bash

echo ''
echo 'Installing tmux ...'

sudo apt install tmux -y

$(dirname $0)/sub_mklink_config.sh tmux

# install tmux plugin manager
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Remind message
echo ""
echo "Don't forget to install tmux plugins by pressing 'prefix + I' in tmux."
read -p "Press any key to continue..."
