#!/bin/bash

# 0. Select mode
read -p "Do you want to setup interactively? (y or else): " ans
if [[ $ans = 'y' ]]; then
  mode=interactive
fi

# 1. make symlinks in HOME
homesrc=$(cd $(dirname $0)/..;pwd)
for file in `ls -AF $homesrc`; do
  if [[ -d $file -o $file != .* ]]; then
    # Skip directories and normal files.
    continue
  fi
  set -x
	ln -sb $homesrc/$file ~/$file
  set +x
done

# 2. make 
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
  set -x
  mkdir -p $dstdir
  set +x
  for file in `ls -A $srcdir`; do
    set -x
    ln -sb $srcdir$file $dstdir$file
    set +x
  done
done


# make tig dir for tig_history not in HOME dir.
set -x
mkdir -p ~/.local/share/tig/
set +x
