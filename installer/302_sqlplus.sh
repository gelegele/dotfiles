#!/usr/bin/env bash

sudo mkdir -p /opt/oracle

wget https://download.oracle.com/otn_software/linux/instantclient/1912000/instantclient-basic-linux.x64-19.12.0.0.0dbru.zip
sudo /home/linuxbrew/.linuxbrew/bin/unzip -d /opt/oracle instantclient-basic-linux.x64-19.12.0.0.0dbru.zip
rm ./instantclient-basic-linux.x64-19.12.0.0.0dbru.zip

wget https://download.oracle.com/otn_software/linux/instantclient/1912000/instantclient-sqlplus-linux.x64-19.12.0.0.0dbru.zip
sudo /home/linuxbrew/.linuxbrew/bin/unzip -d /opt/oracle instantclient-sqlplus-linux.x64-19.12.0.0.0dbru.zip
rm ./instantclient-sqlplus-linux.x64-19.12.0.0.0dbru.zip

wget https://ftp.debian.org/debian/pool/main/liba/libaio/libaio1_0.3.113-4_amd64.deb
sudo dpkg -i ./libaio1_0.3.113-4_amd64.deb
rm ./libaio1_0.3.113-4_amd64.deb

if grep -q instantclient_19_12 ~/.config/zsh/.zshrc.local; then 
  exit
fi
cat << EOF >> ~/.config/zsh/.zshrc.local
export PATH=/opt/oracle/instantclient_19_12:\$PATH
export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_12:\$LD_LIBRARY_PATH
EOF

