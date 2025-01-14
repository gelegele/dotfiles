#!/usr/bin/env bash

echo ''
echo 'Install starship ... '

brew install starship

$(dirname $0)/sub_mklink_config.sh starship

