#!/bin/bash

sudo apt install tig -y

# make tig dir for tig_history not in HOME dir.
makedir="mkdir -p ~/.local/share/tig/"
echo $makedir
$makedir
