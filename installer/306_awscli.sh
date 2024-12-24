#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# aws configure で利用準備をすることを促すメッセージを表示
echo ""
echo "Please run 'aws configure' to set up your AWS CLI"
read -p "Press any key to continue..."
