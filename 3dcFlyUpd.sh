#!/bin/bash
EDITOR=vim
COIN_NAME="3dcoin"
FOLDER="3dcoin"
CONFIG_FOLDER="$HOME/.$FOLDER"
TMP_FOLDER="/tmp"
CONFIG_FILE="$COIN_NAME.conf"
DE="d"
COIN_DAEMON="$COIN_NAME$DE"
COIN_CLI="$COIN_NAME-cli"
COIN_PATH="/usr/local/bin/"
COIN_PORT=6695
RPC_PORT=6694
COIN_KEY=""
NODE_IP=""
COIN_TGZ=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
COIN_ZIP="3dcoin_latest.zip"

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'
MAG='\e[1;35m'

printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     $COIN DAEMON FLY REPLACE   $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"

			3dcoin-cli stop
			sleep 10
rm -f /root/.3dcoin/banlist.dat
rm -f /root/.3dcoin/mncache.dat
rm -f /root/.3dcoin/mnpayments.dat
rm -f /root/.3dcoin/fee_estimates.dat
rm -f /root/.3dcoin/netfulfilled.dat
rm -f /root/.3dcoin/governance.dat
rm -f /root/.3dcoin/debug.log


crontab -l > crontab
			echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
			  apt -y install zip unzip curl >/dev/null 2>&1
			  printf "\n\n         Installed Utility" 
			  cd 
			  cd $TMP_FOLDER >/dev/null 2>&1
			  wget -q $COIN_TGZ
			  printf "\n        Downloaded Daemon" 
			  if [[ $? -ne 0 ]]; then
			   echo -e 'Error downloading node. Please contact support'
			   exit 1
			  fi
			  unzip -j $COIN_ZIP
			  $COIN_PATH$COIN_CLI stop > /dev/null 2>&1
			  service $COIN_NAME stop > /dev/null 2>&1
			  $COIN_CLI stop > /dev/null 2>&1
			  sleep 2
			  cp $COIN_DAEMON $COIN_PATH 
			  cp $COIN_CLI $COIN_PATH     
			  sleep 2
			 3dcoind -daemon