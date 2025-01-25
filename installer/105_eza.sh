#!/usr/bin/env bash

echo "Installing eza..."
brew install eza

# Configure theme in XDG_CONFIG_HOME
source $(dirname $0)/../home/.zshenv
ezadir=$XDG_CONFIG_HOME/eza
rm -rf $ezadir
mkdir -p $ezadir
git clone --depth 1 https://github.com/eza-community/eza-themes.git $ezadir/eza-themes
ln -sf $ezadir/eza-themes/themes/frosty.yml $ezadir/theme.yml

