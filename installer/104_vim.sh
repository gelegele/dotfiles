#!/bin/bash

echo ''
echo 'Install vim ... '

sudo apt install -y vim

$(dirname $0)/sub_mklink_config.sh vim

