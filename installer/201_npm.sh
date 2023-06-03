#!/bin/bash

echo 'Install LTS node by nvm.'
source ~/.config/nvm/nvm.sh
nvm install --lts
npm update -g npm

# config
$(dirname $0)/sub_mklink_config.sh npm

echo 'npm was installed.'
echo 'Logout your terminal and execute 21x_xxx.sh'
