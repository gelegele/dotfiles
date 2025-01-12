#!/usr/bin/env bash

echo ''
echo 'Installing lazygit ...'

brew install lazygit

# config
$(dirname $0)/sub_mklink_config.sh lazygit

