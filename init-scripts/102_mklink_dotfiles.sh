#!/bin/bash

# ../dotfileたちのsymlinkをホームディレクトリに作成
src=$(cd $(dirname $0)/..;pwd)
dst=~

for file in `ls -A $src`; do
  if [[ -d $file ]]; then
    continue
  fi
	lncmd="ln -sb $src/$file $dst/$file"
  echo $lncmd
	$lncmd
done
