#!/usr/bin/env bash
# Usage: . "$(dirname "$0")/sub_load_nvm.sh"

export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"

if ! command -v brew &>/dev/null; then
  # Ensure brew is on PATH when this is sourced from a non-login bash.
  case $OSTYPE in
    darwin*)
      for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [[ -x $brew_bin ]] && eval "$($brew_bin shellenv)" && break
      done
      ;;
    linux*)
      [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] &&
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ;;
  esac
fi

if ! command -v brew &>/dev/null; then
  echo "brew not found. Run 100_bootstrap.sh / 101_brew_basic_apps.sh first." 1>&2
  return 1 2>/dev/null || exit 1
fi

NVM_SH="$(brew --prefix nvm)/nvm.sh"

if [[ ! -s "$NVM_SH" ]]; then
  echo "nvm not found at $NVM_SH. Run 101_brew_basic_apps.sh first." 1>&2
  return 1 2>/dev/null || exit 1
fi

. "$NVM_SH"
