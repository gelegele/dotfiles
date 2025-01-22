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

echo "Type your tnsname like ORCL"
read tnsname
echo "Type your Oracle server IP address like 192.168.0.1"
read ipaddress
echo "Type your Oracle SID"
read sid

sudo sh -c "cat << EOF > /opt/oracle/instantclient_19_12/network/admin/tnsnames.ora
$tnsname =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $ipaddress)(PORT = 1521))
    (CONNECT_DATA =
      (SID = $sid)
    )
  )
EOF
"

if grep -q instantclient_19_12 ~/.config/zsh/.zshrc.local; then 
  exit
fi
cat << EOF >> ~/.config/zsh/.zshrc.local
# for sqlplus
export PATH=/opt/oracle/instantclient_19_12:\$PATH
export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_12:\$LD_LIBRARY_PATH
export NLS_LANG=Japanese_Japan.AL32UTF8
EOF

