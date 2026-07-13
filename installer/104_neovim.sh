#!/usr/bin/env bash

echo ''
echo 'Install Neovim ...'

brew install neovim

# config
$(dirname $0)/sub_mklink_config.sh nvim

