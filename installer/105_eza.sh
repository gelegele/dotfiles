#!/usr/bin/env bash

brew install eza

source $(dirname $0)/../home/.zshenv

# Configure theme in XDG_CONFIG_HOME
rm -rf $XDG_CONFIG_HOME/eza
mkdir -p $XDG_CONFIG_HOME/eza
cd $XDG_CONFIG_HOME/eza
git clone --depth 1 https://github.com/eza-community/eza-themes.git
ln -sf $XDG_CONFIG_HOME/eza/eza-themes/themes/frosty.yml $XDG_CONFIG_HOME/eza/theme.yml

