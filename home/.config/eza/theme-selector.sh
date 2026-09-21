#!/usr/bin/env bash

source ~/.zshenv
ezaconfigdir=$XDG_CONFIG_HOME/eza

if [ ! -d "$ezaconfigdir/eza-themes" ]; then
  git clone --depth 1 https://github.com/eza-community/eza-themes.git "$ezaconfigdir/eza-themes"
fi

shopt -s nullglob
themes=()
for themefile in "$ezaconfigdir/eza-themes/themes"/*; do
  themes+=("$(basename "$themefile")")
done

if (( ${#themes[@]} == 0 )); then
  echo "No eza themes found in $ezaconfigdir/eza-themes/themes" >&2
  exit 1
fi

PS3="Select an eza theme > "
select themefile in "${themes[@]}"
do
  if [ -n "$themefile" ]; then
    break
  fi
  echo "Select a number in the list."
done

ln -sf "$ezaconfigdir/eza-themes/themes/$themefile" "$ezaconfigdir/theme.yml"
echo "eza themefile changed $themefile"
eza -l
