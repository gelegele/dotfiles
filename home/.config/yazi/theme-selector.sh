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
add_yazi_pkg() {
  ya pkg add "$1" 2>/dev/null || ya pack -a "$1" 2>/dev/null || true
}
for url in "${themeurls[@]}"; do
  add_yazi_pkg "$url"
done

# for $XDG_CONFIG_HOME
source ~/.zshenv

# Select theme
flavors_dir="$XDG_CONFIG_HOME/yazi/flavors"
shopt -s nullglob
themes=()
for flavor in "$flavors_dir"/*.yazi; do
  themes+=("$(basename "$flavor" .yazi)")
done

if (( ${#themes[@]} == 0 )); then
  echo "No yazi flavors found in $flavors_dir" >&2
  exit 1
fi

PS3="Select an yazi theme > "
select themename in "${themes[@]}"
do
  if [ -n "$themename" ]; then
    break
  fi
  echo "Select a number in the list."
done

# Update yazi theme
cat > "$XDG_CONFIG_HOME/yazi/theme.toml" << EOF
[flavor]
dark = "$themename"
EOF

echo "yazi theme changed $themename."
