#!/usr/bin/env bash
# Usage: . "$(dirname "$0")/sub_load_nvm.sh"

export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
case $OSTYPE in
  darwin*) NVM_SH="/usr/local/opt/nvm/nvm.sh" ;;
  linux*)  NVM_SH="/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ;;
esac

if [[ ! -s "$NVM_SH" ]]; then
  echo "nvm not found at $NVM_SH. Run 101_brew_basic_apps.sh first." 1>&2
  return 1 2>/dev/null || exit 1
fi

. "$NVM_SH"
