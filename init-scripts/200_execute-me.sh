#!/bin/bash

# フォルダ配下の2xx_xxx.shを順番に実行する
# 20番台以外は対話形式での任意実行

dir=$(dirname $0)

echo "Execute sh files in $dir folder."
for f in $(ls $dir); do
  if [[ "$f" = $(basename $0) ]]; then
    continue
  fi
  if [[ "$f" != 2??_*.sh ]]; then
    continue
  fi
  if [[ "$f" != 20?_*.sh ]]; then
    # Options
    read -p "Do you execute ${f}? [y/n]: " yn
    if [[ $yn = [nN] ]]; then
      echo 'Skiped.'
      continue
    fi
  fi
  chmod u+x $dir/$f
  echo "Executing $f..."
  $dir/$f
done
echo "Done."
