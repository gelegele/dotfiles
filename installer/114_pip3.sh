#!/bin/bash

echo ''
echo 'Install pip3 ...'

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
rm get-pip.py

