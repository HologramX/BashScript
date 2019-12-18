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
choice=""
NODE_IP=""
COIN_TGZ=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
COIN_ZIP="3dcoin_latest.zip"
COIN_TGZ18=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest18.zip
COIN_ZIP18="3dcoin_latest18.zip"

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'
	


##### Main #####
clear
printf "\n"
printf "${YELLOW}#################################################################${NC}\n"
printf "${GREEN}            3DC FAST UPDATE   ** UBUNTU 16 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}"
echo ""
yes | apt-get install dnsutils
echo ""
echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
cd 
cd $COIN_PATH >/dev/null 2>&1
rm *.zip* >/dev/null 2>&1
wget -q $COIN_TGZ
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
$COINPATH$COIN_DAEMON stop
sleep 10
kill -9 $(pgrep $COIN_DAEMON) > /dev/null 2>&1
kill -9 $(pgrep 3DCOIN_SHUTDOWN) > /dev/null 2>&1
sleep 2
unzip -o -j $COIN_ZIP
rm *.zip* >/dev/null 2>&1
cd 
rm *.tar* > /dev/null 2>&1
rm ./3dc*.sh* > /dev/null 2>&1 && reboot
