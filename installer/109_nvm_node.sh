#!/usr/bin/env bash

# Install Node.js via nvm (nvm itself is installed in 101_brew_basic_apps.sh).
# Keeps node/npm available for later installer scripts (e.g. 203+).

echo "Install Node.js via nvm..."

$(dirname "$0")/sub_mklink_config.sh npm

. "$(dirname "$0")/sub_load_nvm.sh"

if type node &>/dev/null; then
  echo "Node.js already installed: $(node -v)"
  exit 0
fi

nvm install node
