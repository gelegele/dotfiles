#!/usr/bin/env bash

echo ''
echo 'Installing tmux and tmux-plugins/tpm ...'

brew install tmux  tpm

$(dirname $0)/sub_mklink_config.sh tmux

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Remind message
echo ""
echo "Don't forget to install tmux plugins by pressing 'prefix + I' in tmux."
read -p "Press any key to continue..."

