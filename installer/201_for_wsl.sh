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

# Add /etc/fonts/local.conf to activate Windows fonts for GUI.
cat << 'EOS' | sudo tee /etc/fonts/local.conf
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <dir>/mnt/c/Windows/Fonts</dir>
</fontconfig>
EOS

# System clipboard
$(dirname $0)/sub_mklink_config.sh win32yank

# Open url by Windows Browser.
npm install -g wsl-open
sudo ln -sf $(which wsl-open) /usr/local/bin/xdg-open

