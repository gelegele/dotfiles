#!/bin/bash

echo ''
echo 'Install vifm ... '

sudo apt install -y vifm

$(dirname $0)/sub_mklink_config.sh vifm

