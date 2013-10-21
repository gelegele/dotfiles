#!/bin/sh

if [ $# -eq 0 ]; then
  echo "No args. Specify a source directory."
  exit 1
elif [ $# -gt 2 ]; then
  echo "Too many args."
  exit 1
fi

if [ ! -d $1 ]; then
  echo "$1 is not a directory."
  exit 1
fi
src=$1

dst=./
if [ $# -eq 2 ]; then
  if [ ! -d $2 ]; then
    echo "$2 is not a directory."
    exit 1
  fi
  dst=$2
fi


for file in `ls -a $src`; do
  if [ $file = "." -o $file = ".." -o $file = ".DS_Store" -o $file = ".git" -o $file = "`basename $0`" ]; then
    continue
  fi
	lncmd="ln -sb $src$file $dst$file"
  echo $lncmd
	$lncmd
done
