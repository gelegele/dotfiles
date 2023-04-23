#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl vim git tig ssh source-highlight tree unzip

packages=(tmux language-pack-ja python3-pip ipython3)
for p in "${packages[@]}"
do
  read -p "Do you install ${p}? [y/n]: " yn
  if [[ $yn = [yY] ]]; then
    sudo apt install -y $p
  fi
done
sudo apt autoremove
