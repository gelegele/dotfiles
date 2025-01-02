#!/bin/bash

echo ''
echo 'Install git ... '

sudo apt install -y git git-delta
# git-delta is a viewer for git and diff output

$(dirname $0)/sub_mklink_config.sh git

