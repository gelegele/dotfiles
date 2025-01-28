#!/usr/bin/env bash

if [[ "$(uname -r)" != *microsoft* ]]; then
  echo 'You are not on WSL. This is not necessary.'
  exit
fi

# Mod /etc/wsl.conf to exclude Windows PATH
sudo mv --no-clobber /etc/wsl.conf /etc/wsl.conf.bak
sudo sh -c "cat <<EOF > /etc/wsl.conf
[boot]
systemd=true
[interop]
appendWindowsPath = false # To exclude Windows PATH
EOF
"

# System clipboard
$(dirname $0)/sub_mklink_config.sh win32yank

# Open url by Windows Browser.
$(dirname $0)/sub_load_nvm.sh
npm install -g wsl-open
sudo ln -sf $(which wsl-open) /usr/local/bin/xdg-open

