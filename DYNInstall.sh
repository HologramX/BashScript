#!/bin/bash
EDITOR=vim
COIN_NAME="dynamic"
TMP_FOLDER="/tmp"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'

yes | apt-get update
yes | apt-get upgrade

echo ""
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
echo ""
rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')
rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
rpcport=33350
port=33300
#----
listen=1
server=1
daemon=1
maxconnections=32
#----
dynode=1
dynodepairingkey=$pv
#----"
yes |  apt-get remove apache2 -y
yes |  apt-get remove apache2  -y
yes |  apt-get remove apache2-bin  -y
yes |  apt-get remove apache2-data  -y
yes |  apt-get remove apache2-doc  -y
yes |  apt-get remove apache2-utils  -y
yes |  apt-get remove postfix  -y 
yes |  apt-get autoremove -y
yes |  apt-get autoclean -y
cd ~
wget https://github.com/duality-solutions/Dynamic/releases/download/v2.3.5.0/Dynamic-2.3.5.0-Linux-x64.tar.gz
tar -xvzf Dynamic-2.3.5.0-Linux-x64.tar.gz
cp /root/dynamic-2.3.5/bin/* /usr/local/bin/
cd ~
mkdir /root/.dynamic
echo "$config" > /root/.dynamic/dynamic.conf
cd ~
rm Dynamic*.gz*
/usr/local/bin/dynamicd -daemon
