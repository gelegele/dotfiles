#!/usr/bin/env bash

echo ''
echo 'Install yazi ... '

brew install yazi

$(dirname $0)/sub_mklink_config.sh yazi

ya pack -a yazi-rs/flavors:dracula
ya pack -a yazi-rs/flavors:catppuccin-mocha
ya pack -a yazi-rs/flavors:catppuccin-frappe
ya pack -a BennyOe/tokyo-night
ya pack -a sanjinso/monokai-vibrant

