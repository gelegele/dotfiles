#!/bin/bash

echo ''
echo 'Install vifm ... '

sudo apt install -y vifm

$(dirname $0)/sub_mklink_config.sh vifm

# to show icons
curl -m 1 --retry 3 https://raw.githubusercontent.com/thimc/vifm_devicons/master/favicons.vifm -o $HOME/.config/vifm/favicons.vifm

