#!/usr/bin/env bash

# make symlinks of dotfiles in HOME
homesrc=$(cd $(dirname $0)/../home;pwd)
homedst=~
for file in `ls -Ap $homesrc`; do
  if [[ $file == */ || $file != .* ]]; then
    # Skip directories and normal files.
    continue
  fi
  src=${homesrc}/${file}
  dst=${homedst}/${file}
  if [[ -f $dst ]]; then
    # Backup if dst file exists.
    mv --no-clobber ${dst} ${dst}.bak
  fi
  makeln="ln -sf $src $dst"
  echo $makeln
	$makeln
done

