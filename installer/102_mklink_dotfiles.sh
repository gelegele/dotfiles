#!/usr/bin/env bash

# make symlinks of dotfiles in HOME
homesrc=$(cd "$(dirname "$0")/../home" && pwd)
homedst=~

for file in "$homesrc"/.*; do
  name="$(basename "$file")"
  # Skip . and .. and directories
  [[ "$name" == "." || "$name" == ".." ]] && continue
  [[ -d "$file" ]] && continue
  [[ -e "$file" ]] || continue

  src="$file"
  dst="$homedst/$name"

  # Skip if destination is already linked to the correct source
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    continue
  fi

  # Backup existing regular file (not symlink)
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv -n "$dst" "${dst}.bak"
  fi

  echo "ln -sf $src $dst"
  ln -sf "$src" "$dst"
done

