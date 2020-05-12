#!/bin/bash
TMP_FOLDER="/tmp"
choice=""
NODE_IP=""
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
echo  -e "${GREEN} Start VPS UPGRADE/UPDATE        ${STD}"
sleep 1
h=$(( RANDOM % 23 + 1 ));
echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
yes | apt-get update

DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
yes | apt-get install git unzip pv nano htop
yes | apt-get install curl fail2ban ufw python virtualenv git unzip pv nano htop libwww-perl
echo  -e "${GREEN} Firewall setup.....              ${STD}"
 ufw allow ssh/tcp
 ufw limit ssh/tcp 
 ufw logging on 
yes |  ufw enable 
echo ""
export LC_ALL=en_US.UTF-8
yes |  apt-get update
yes |  apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes |  apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes |  apt-get install software-properties-common
yes |  add-apt-repository ppa:bitcoin/bitcoin
yes |  apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install libdb4.8-dev libdb4.8++-dev
yes |  apt-get install libminiupnpc-dev
yes |  apt-get install libzmq3-dev
yes | apt-get install sshpass
sleep 2
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

echo ""
echo " Check and Setup Swapfile....."
SWAPSIZE=$(cat /proc/meminfo | grep SwapTotal | awk '{print $2}')
FREESPACE=$(df / | tail -1 | awk '{print $4}')
if [ $SWAPSIZE -lt 4000000 ]
  then if [ $FREESPACE -gt 6000000 ]
    then  fallocate -l 4G /swapfile
		 chmod 600 /swapfile
		 mkswap /swapfile 
		 swapon /swapfile
		echo "/swapfile none swap sw 0 0" >> /etc/fstab
    else echo 'Swap seems smaller than recommended. It cannot be increased because of lack of space'
		pause
    fi
fi  
echo ""
rm *.sh* && reboot
