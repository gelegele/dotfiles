#!/usr/bin/env bash

themeurls=(
  yazi-rs/flavors:dracula
  yazi-rs/flavors:catppuccin-mocha
  yazi-rs/flavors:catppuccin-frappe
  BennyOe/tokyo-night
  sanjinso/monokai-vibrant
  tkapias/nightfly
  tkapias/moonfly
)
# Pull themes
for url in ${themeurls[@]}; do
  ya pack -a $url 2>/dev/null
done

# for $XDG_CONFIG_HOME
source ~/.zshenv

# Select theme
PS3="Select an yazi theme > "
select themename in $(ls $XDG_CONFIG_HOME/yazi/flavors/ | sed s/.yazi//g)
do
  if [ -n "$themename" ]; then
    break;
  fi
  echo "Select a number in the list."
done

# Update yazi theme
cat > ~/.config/yazi/theme.toml << EOF
[flavor]
dark = "$themename"
EOF

echo "yazi theme changed $themename."

