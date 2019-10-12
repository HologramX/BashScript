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

dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v `uname -r`
apt-get purge linux-image-4.4.0-139-generic
apt-get purge linux-image-4.4.0-140-generic
apt-get purge linux-image-4.4.0-141-generic
apt-get purge linux-image-4.4.0-142-generic
apt-get purge linux-image-4.4.0-143-generic
apt-get purge linux-image-4.4.0-144-generic
apt-get purge linux-image-4.4.0-145-generic
apt-get purge linux-image-4.4.0-146-generic
apt-get purge linux-image-4.4.0-147-generic
apt-get purge linux-image-4.4.0-148-generic
apt-get purge linux-image-4.4.0-149-generic
apt-get purge linux-image-4.4.0-150-generic
apt-get -f -y install
apt-get install perl -y
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
rm -r /usr/tmp/*
rm *.sh*

 
