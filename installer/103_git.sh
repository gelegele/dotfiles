#!/bin/bash

echo ''
echo 'Install git ... '

sudo apt install -y git

$(dirname $0)/sub_mklink_config.sh git

