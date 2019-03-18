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
cd /var/log/
rm *.gz*
rm *.1 > /dev/null 2>&1
rm *.2 > /dev/null 2>&1
rm *.3 > /dev/null 2>&1
echo > btmp.log
echo > auth.log
echo > ufw.log
echo > kern.log
echo > .3dcoin/debug.log
rm -r journal/*
rm *.sh*
reboot
