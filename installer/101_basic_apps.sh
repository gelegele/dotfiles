#!/bin/bash

echo ''

sudo apt update -y
sudo apt upgrade -y

defaultpackages=(less curl wget ssh source-highlight tree unzip fzf zoxide bat python3-pip neofetch golang-go language-pack-ja build-essential)
echo "apt install $defaultpackages"
sudo apt install -y ${defaultpackages[@]}

packages=(ipython3)
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
