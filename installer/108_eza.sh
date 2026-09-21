#!/usr/bin/env bash

source $(dirname $0)/../home/.zshenv

echo "Installing eza..."
brew install eza

# Configure theme in XDG_CONFIG_HOME
$(dirname $0)/sub_mklink_config.sh eza

# Clone themes (if needed) and select one
~/.config/eza/theme-selector.sh
