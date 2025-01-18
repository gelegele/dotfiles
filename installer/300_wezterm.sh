#!/usr/bin/env bash

if [[ "$(uname -r)" == *microsoft* ]]; then
  echo 'You are on WSL. No need this.'
  exit
fi

echo ''
echo 'Install wezterm ...'
brew install --cask wezterm

$(dirname $0)/sub_mklink_config.sh wezterm

