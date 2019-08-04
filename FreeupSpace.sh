#!/bin/bash
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'

apt-get remove perl -y
apt-get clean
apt-get autoremove -y
apt-get autoclean -y
rm -r 3dcoin
rm -r 3dcoin-0.14.1.2
echo > .3dcoin/debug.log
cd /var/log/
rm *.gz*
rm *.1 > /dev/null 2>&1
rm *.2 > /dev/null 2>&1
rm *.3 > /dev/null 2>&1
cd /var/log/
rm *.gz*
rm *.zip*
rm *.1
echo > btmp.log
echo > auth.log
echo > ufw.log
echo > kern.log
rm -r journal/*
rm *.sh*

systemctl stop Hera
systemctl disable Hera
/usr/local/bin/Herad stop >/dev/null 2>&1
rm -f /usr/local/bin/Herad 
rm -f /usr/local/bin/Hera-cli
rm -r .Hera
crontab -l | grep Herad >/dev/null 2>&1
if [[ $? -eq 0 ]]
 then 
  crontab -u root -l | grep -v '@reboot /usr/local/bin/Herad -daemon'  | crontab -u root -
  printf "\n        Crontab SET SUCCESFULL"
 fi

systemctl stop sucre
systemctl disable sucre
/usr/local/bin/sucr-cli  stop >/dev/null 2>&1
rm -f /usr/local/bin/sucrd 
rm -f /usr/local/bin/sucr-cli
rm -r .sucrecore
rm -r SucreCore
crontab -l | grep sucrd >/dev/null 2>&1
if [[ $? -eq 0 ]]
 then 
  crontab -u root -l | grep -v '@reboot /usr/local/bin/sucrd -daemon'  | crontab -u root -
  printf "\n        Crontab SET SUCCESFULL"
 fi
 
systemctl stop Graph   
systemctl disable Graph
/usr/local/bin/graphcoin-cli stop >/dev/null 2>&1
rm -f /usr/local/bin/graphcoind 
rm -f /usr/local/bin/graphcoin-cli
rm -r .Graphcoincore
crontab -l | grep graphcoin >/dev/null 2>&1
if [[ $? -eq 0 ]]
 then 
  crontab -u root -l | grep -v '@reboot /usr/local/bin/Graphcoind -daemon'  | crontab -u root -
  printf "\n        Crontab SET SUCCESFULL"
 fi
 rm *.sh
 
