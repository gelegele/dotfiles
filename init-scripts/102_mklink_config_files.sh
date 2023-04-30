#!/bin/bash
# Make .config symlinks

read -p "Do you want to setup interactively? (y or else): " ans
if [[ $ans = 'y' ]]; then
  mode=interactive
fi

confdir=$(cd $(dirname $0)/../.config;pwd)

for appdir in `ls -AF $confdir`; do

  if [[ $mode = interactive ]]; then
    # Interactive mode
    read -p "Do you setup ${appdir}? (y or else): " ans
    if [[ $ans != 'y' ]]; then
      echo "Skip ${appdir} setup."
      continue
    fi
  fi

  srcdir=$confdir/$appdir
  dstdir=~/.config/$appdir

  mkdir -p $dstdir

  for file in `ls -A $srcdir`; do
    lncmd="ln -sb $srcdir$file $dstdir$file"
    echo $lncmd
    $lncmd
  done
done

# make tig dir for tig_history not in HOME dir.
mkdir -p .local/share/tig/
