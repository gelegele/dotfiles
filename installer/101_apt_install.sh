#!/bin/bash

set -x
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y less curl vim git tig ssh source-highlight tree unzip
set +x

packages=(tmux language-pack-ja build-essential python3-pip ipython3)
for p in "${packages[@]}"
do
  read -p "Do you install ${p}? [y/n]: " yn
  if [[ $yn = [yY] ]]; then
    set -x
    sudo apt install -y $p
    set +x
  fi
done
set -x
sudo apt autoremove
set +x
