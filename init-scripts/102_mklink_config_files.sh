#!/bin/bash

# Make .config symlinks

confdir=$(cd $(dirname $0)/../.config;pwd)

for appdir in `ls -A $confdir`; do

  srcdir=$confdir/$appdir/
  dstdir=$XDG_CONFIG_HOME/$appdir/

  mkdir -p $dstdir

  for file in `ls -A $srcdir`; do
    lncmd="ln -sb $srcdir$file $dstdir$file"
    echo $lncmd
    $lncmd
  done
done

# make tig dir for tig_history not in HOME dir.
mkdir -p .local/share/tig/
