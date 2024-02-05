#!/bin/bash

# make symlinks of dotfiles in HOME
homesrc=$(cd $(dirname $0)/../home;pwd)
homedst=~
for file in `ls -AF $homesrc`; do
  if [[ $file == */ || $file != .* ]]; then
    # Skip directories and normal files.
    continue
  fi
  makeln="ln -sf $homesrc/$file $homedst/$file"
  echo $makeln
	$makeln
done
