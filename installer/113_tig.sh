#!/bin/bash

sudo apt install tig -y

# make tig dir for tig_history not in HOME dir.
echo 'make dir ~/.local/share/tig/ for tig_history'
mkdir -p ~/.local/share/tig/

