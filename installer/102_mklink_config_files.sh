#!/bin/bash

# 0. Select mode
read -p "Do you want to setup interactively? (y or else): " ans
if [[ $ans = 'y' ]]; then
  mode=interactive
fi

# 1. make symlinks in HOME
homesrc=$(cd $(dirname $0)/..;pwd)
homedst=~
for file in `ls -AF $homesrc`; do
  if [[ -d $file ]] || [[ $file != .* ]]; then
    # Skip directories and normal files.
    continue
  fi
  makeln="ln -sb $homesrc/$file $homedst/$file"
  echo $makeln
	$makeln
done

# 2. make config dirs and symlinks
confdir=$(cd $(dirname $0)/../.config;pwd)
for appdir in `ls -AF $confdir`; do
  if [[ $mode = interactive ]]; then
    # You can skip in interactive mode
    read -p "Do you setup ${appdir}? (y or else): " ans
    if [[ $ans != 'y' ]]; then
      echo "Skip ${appdir} setup."
      continue
    fi
  fi
  srcdir=$confdir/$appdir
  dstdir=~/.config/$appdir
  makedir="mkdir -p $dstdir"
  echo $makedir
  $makedir
  for file in `ls -A $srcdir`; do
    makeln="ln -sb $srcdir$file $dstdir$file"
    echo $makeln
    $makeln
  done
done

# 3. make tig dir for tig_history not in HOME dir.
makedir="mkdir -p ~/.local/share/tig/"
echo $makedir
$makedir
