#!/bin/bash

sudo apt install make

temp=~/temp-git-secrets

git clone --depth 1 https://github.com/awslabs/git-secrets.git $temp
cd $temp
sudo make install

cd ~
rm -rf $temp

echo ''
echo 'You MUST install as bellow.'
echo '$ git secrets --install'
echo '$ git secrets --register-aws'
