#!/bin/bash

z_dir=$XDG_CONFIG_HOME/z

mkdir -p $z_dir
curl -L https://raw.githubusercontent.com/rupa/z/master/z.sh -o $z_dir/z.sh
chmod +x $z_dir/z.sh
