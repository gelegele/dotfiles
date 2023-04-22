#!/bin/bash

z_dir=~/.z.d

mkdir -p $z_dir
curl -L https://raw.githubusercontent.com/rupa/z/master/z.sh -o $z_dir/z.sh
chmod +x $z_dir/z.sh
