#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Set 1 argument as the name of a config directory." 1>&2
  exit 1
fi

appname=$1
echo "Making symlinks of $appname config files..."

confdir=$(cd $(dirname $0)/../home/.config;pwd)
srcdir=$confdir/$appname
dstdir=~/.config/$appname

mkdir -p "$dstdir"
# Include hidden files (dotglob) and safely handle empty dirs (nullglob)
shopt -s nullglob dotglob
for src in "$srcdir"/*; do
  file="$(basename "$src")"
  dst="$dstdir/$file"
  # Keep local-only files; only replace managed paths.
  if [[ -e $dst || -L $dst ]] && [[ ! -L $dst ]]; then
    mv -n "$dst" "${dst}.bak"
  fi
  ln -sfn "$src" "$dst"
done
