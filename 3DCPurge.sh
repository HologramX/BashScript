#!/bin/bash
EDITOR=vim
choice=""
LOCALE="LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8


BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'

kill -9 $(pgrep 3dcoind)
echo ""
echo  -e "${GREEN} Firewall setup.....              ${STD}"
 ufw disable
 ufw delete allow 6695/tcp  
 ufw logging on 
yes |  ufw enable 
echo ""
echo  -e "${GREEN} 3DCoin File remove...               ${STD}"
rm /root/cron*
rm -rf /usr/local/bin/Masternode
rm /usr/local/bin/3dc*
rm -r /root/.3dcoin/
rm 3dcoin*

echo  -e "${GREEN} Crontab Purge.....              ${STD}"
cd ~
crontab -l > cron
crontab -r
sed -i '/3dcoind/d' ./cron
sed -i '/Masternode/d' ./cron
crontab /root/cron
echo  -e "${GREEN} 3DCoin Node PURGED successfully .....               ${STD}"
echo ""

rm 3DC*.sh* > /dev/null 2>&1 
