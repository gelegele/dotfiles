#!/usr/bin/env bash

echo ''
echo 'Link git config dir ... '

$(dirname $0)/sub_mklink_config.sh git

echo 'Install git-delta ... '
brew install git-delta

