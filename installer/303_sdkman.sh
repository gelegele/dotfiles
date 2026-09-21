#!/usr/bin/env bash

echo "Installing sdkman..."

# Must match home/.config/zsh/.zshrc and home/.bashrc
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"

curl -s "https://get.sdkman.io" | bash

# To switch the current jdk as specified in the directory's .sdkmanrc
if sed -i 's/sdkman_auto_env=false/sdkman_auto_env=true/g' "$SDKMAN_DIR/etc/config"; then
  echo "Enabled auto env."
else
  echo "Error! Check sdkman config at $SDKMAN_DIR/etc/config." 1>&2
  exit 1
fi

echo "Relogin to use sdkman"
