#!/bin/bash

# ../dotfileたちのsymlinkをホームディレクトリに作成
src=$(cd $(dirname $0)/..;pwd)
dst=~

for file in `ls -A $src`; do
  if [ $file = "init-scripts" -o $file = ".config" -o $file = ".DS_Store" -o $file = ".git" ]; then
    continue
  fi
	lncmd="ln -sb $src/$file $dst/$file"
  echo $lncmd
	$lncmd
done
