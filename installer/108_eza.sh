#!/usr/bin/env bash

source $(dirname $0)/../home/.zshenv

echo "Installing eza..."
brew install eza

# Configure theme in XDG_CONFIG_HOME
$(dirname $0)/sub_mklink_config.sh eza
git clone --depth 1 https://github.com/eza-community/eza-themes.git $XDG_CONFIG_HOME/eza/eza-themes

# Select eza theme
~/.config/eza/theme-selector.sh

