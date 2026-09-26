#!/usr/bin/env bash

# For Debian and Ubuntu
if type apt-get &> /dev/null; then
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y build-essential procps curl file git dnsutils
  if  [ -e /etc/lsb-release ]; then
    sudo apt install -y language-pack-ja
  else
    sudo apt install -y locales
  fi 
fi

# Install Homebrew and set PATH temporary if needed
if ! command -v brew &> /dev/null; then
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

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  case $OSTYPE in
    darwin*)
      for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [[ -x $brew_bin ]] && eval "$($brew_bin shellenv)" && break
      done
      ;;
    linux*)
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ;;
  esac
fi

# Execute 1xx_xxx.sh
dir=$(dirname $0)
echo "Execute 1xx_xxx.sh files in $dir folder."
for f in $(ls $dir); do
  if [[ "$f" = $(basename $0) ]]; then
    # skip this file.
    continue
  fi
  if [[ "$f" != 1??_*.sh ]]; then
    continue
  fi
  chmod u+x $dir/$f
  echo ""
  echo "Executing $f ..."
  $dir/$f
done
echo ""
echo "Done. Log out your terminal and execute installer/200_bootstrap.sh"

