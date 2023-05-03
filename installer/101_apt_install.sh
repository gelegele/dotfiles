#!/bin/bash

echo ''

sudo apt update -y
sudo apt upgrade -y

defaultpackages=(less curl wget vim git tig ssh source-highlight tree unzip)
echo "apt install $defaultpackages"
sudo apt install -y ${defaultpackages[@]}

packages=(language-pack-ja build-essential python3-pip ipython3)
for p in "${packages[@]}"
do
  read -p "Do you install ${p}? [y/n]: " yn
  if [[ $yn = [yY] ]]; then
    echo ""
    echo "apt install $p"
    sudo apt install -y $p
  fi
done
sudo apt autoremove -y
