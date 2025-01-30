#!/usr/bin/env bash

echo ''
echo 'Installing git-secrets'
brew install git-secrets

echo ''
echo 'You MUST install as bellow.'
echo '$ git secrets --install'
echo '$ git secrets --register-aws'
read -p "Press any key to continue."

