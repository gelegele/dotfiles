#!/bin/bash

# https://docs.docker.com/engine/install/debian/#installation-methods
# ※下記のURLをdebianからubuntuに書き換える必要がある
# https://download.docker.com/linux/debian -> https://download.docker.com/linux/ubuntu

echo ""
echo "Installing docker-ce"

if cat /etc/issue | grep -i ubuntu; then
  distro=ubuntu
elif cat /etc/issue | grep -i debian; then
  distro=debian
else
  echo ubuntu でも debian でもないのでURLが対応できませんね
  exit 1
fi

sudo apt update -y
sudo apt install -y ca-certificates curl gnupg

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$distro \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker --version
sudo service docker start

# WSLだとエラーになるのでこれをたたく
if [[ "$(uname -r)" == *microsoft* ]]; then
  sudo gpasswd -a $(whoami) docker
  sudo chgrp docker /var/run/docker.sock
  sudo service docker restart
  echo 'You have to exit now.'
fi
