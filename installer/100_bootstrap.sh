#!/bin/bash

# フォルダ配下の1xx_xxx.shを順番に実行する
# 100番台以外は対話形式での任意実行

dir=$(dirname $0)

echo "Execute 1xx_xxx.sh files in $dir folder."
for f in $(ls $dir); do
  if [[ "$f" = $(basename $0) ]]; then
    # skip this file.
    continue
  fi
  if [[ "$f" != 1??_*.sh ]]; then
    continue
  fi
  if [[ "$f" != 10?_*.sh ]]; then
    # Options
    read -p "Do you execute ${f}? [y/n]: " yn
    if [[ $yn = [nN] ]]; then
      echo 'Skiped.'
      continue
    fi
  fi
  chmod u+x $dir/$f
  echo ""
  echo "Executing $f ..."
  $dir/$f
done
echo ""
echo "Done. Log out your terminal and execute installer/200_nvm_install.sh"
