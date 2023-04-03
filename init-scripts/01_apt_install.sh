#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y zsh vim language-pack-ja git tig ssh source-highlight tree unzip

packages=(fzf python3-pip ipython3)
for p in "${packages[@]}"
do
  read -p "Do you install ${p}? [y/n]: " yn
  if [[ $yn = [yY] ]]; then
    sudo apt install -y $p
  fi
done
sudo apt autoremove
