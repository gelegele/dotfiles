#!/bin/bash

# ../dotfileたちのsymlinkをホームディレクトリに作成
src=$(cd $(dirname $0)/..;pwd)
dst=~

for file in `ls -AF $src`; do
  if [[ -d $file ]]; then
    # Skip directories
    continue
  fi
	lncmd="ln -sb $src/$file $dst/$file"
  echo $lncmd
	$lncmd
done
