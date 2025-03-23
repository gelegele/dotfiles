#!/usr/bin/env bash

echo "Installing sdkman..."
curl -s "https://get.sdkman.io" | bash

# To switch the current jdk as specified in the directory's .sdkmanrc
sed -i 's/sdkman_auto_env=false/sdkman_auto_env=true/g' ~/.config/sdkman/etc/config
if [ $? -eq 0 ]; then
  echo "Enabled auto env."
else
  echo "Error! Check sdkman config."
fi

echo "Relogin to use sdkman"

