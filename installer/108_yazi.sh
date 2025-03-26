#!/usr/bin/env bash

echo ''
echo 'Install yazi ... '

brew install yazi

$(dirname $0)/sub_mklink_config.sh yazi

# Select eza theme
~/.config/yazi/theme-selector.sh

