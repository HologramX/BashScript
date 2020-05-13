#!/bin/bash
EDITOR=vim
choice=""
COIN_TGZ=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
COIN_ZIP="3dcoin_latest.zip"
COIN_TGZ18=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest18.zip
COIN_ZIP18="3dcoin_latest18.zip"
LOCALE="LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANGUAGE=en:it:en"


BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'


pause(){
  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
}

kill -9 $(pgrep 3dcoind)
echo ""
echo  -e "${GREEN} Firewall setup.....              ${STD}"
 ufw disable
 ufw delete allow 6695  
 ufw logging on 
yes |  ufw enable 
echo ""
rm /root/cron*
rm -rf /usr/local/bin/Masternode
rm /usr/local/bin/3dc*
rm -r /root/3dcoin
rm jail.local

cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
sed -i '/3dcoind/d' ./cron
sed -i '/Masternode/d' ./cron
crontab /root/cron
echo  -e "${GREEN} 3DCoin PURGED successfully .....               ${STD}"
echo ""

rm 3DC*.sh* > /dev/null 2>&1 
