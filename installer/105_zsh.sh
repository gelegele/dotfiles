#!/usr/bin/env bash

echo ''
echo 'Install zsh ... '

if type apt-get > /dev/null 2>&1; then
  # Coudn't Change default shell to zsh installed by Homebrew on Debian
  sudo apt install -y zsh source-highlight
else
  brew install zsh source-highlight
fi

$(dirname $0)/sub_mklink_config.sh zsh

echo 'Install plugin manager ...'
brew install sheldon
$(dirname $0)/sub_mklink_config.sh sheldon

echo 'Change default shell zsh.'
chsh -s $(which zsh)

