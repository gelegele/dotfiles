#!/bin/bash

# フォルダ配下の3xx_xxx.shを順番に実行する

dir=$(dirname $0)

echo "Execute 3xx_xxx.sh files in $dir folder."
for f in $(ls $dir); do
  if [[ "$f" = $(basename $0) ]]; then
    # skip this file.
    continue
  fi
  if [[ "$f" != 3??_*.sh ]]; then
    continue
  fi

  read -p "Do you execute ${f}? [y/n]: " yn
  if [[ $yn = [nN] ]]; then
    echo 'Skiped.'
    continue
  fi
  chmod u+x $dir/$f
  echo ""
  echo "Executing $f ..."
  $dir/$f
done
echo ""
echo "Done."
