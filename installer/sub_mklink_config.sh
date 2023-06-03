#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Set 1 argument as the name of a config directory." 1>&2
  exit 1
fi

appname=$1
echo "Making symlinks of $appname config files..."

confdir=$(cd $(dirname $0)/../.config;pwd)
srcdir=$confdir/$appname
dstdir=~/.config/$appname

rm -rf $dstdir 2> /dev/null
mkdir -p $dstdir
for file in `ls -A $srcdir`; do
  ln -sb $srcdir/$file $dstdir/$file
done

