#!/usr/bin/env bash

echo ''
echo 'Install vim ... '

brew install vim

$(dirname $0)/sub_mklink_config.sh vim

