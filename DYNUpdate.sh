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
echo ""
yes | apt-get update
yes | apt-get upgrade
yes |  apt-get autoremove -y
yes |  apt-get autoclean -y
dynamic-cli stop
sleep 10
kill -9 $(pgrep dynamicd)
kill -9 $(pgrep dynamic-shutoff)
wget https://github.com/duality-solutions/Dynamic/releases/download/v2.4.4.0/Dynamic-2.4.4.0-Linux-x64.tar.gz
tar -xvzf Dynamic-2.4.4.0-Linux-x64.tar.gz
cp /root/dynamic-2.4.4/bin/* /usr/local/bin/
rm Dynamic*.gz*
rm -r dynamic-2.4.0/
rm -r dynamic-2.4.1/
rm -r dynamic-2.4.2/
rm -r dynamic-2.4.3/
rm -r dynamic-2.4.4/
cp /root/.dynamic/dynamic.conf /root
rm -r .dynamic
mkdir /root/.dynamic
cp /root/dynamic.conf /root/.dynamic

/usr/local/bin/dynamicd -daemon
rm *.sh
