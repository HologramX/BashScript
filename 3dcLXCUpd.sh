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

#cd ~
kill -9 $(pgrep 3dcoind) > /dev/null 2>&1
#cd /usr/local/bin
#unzip -o -j $COIN_ZIP
#cd /root
#cp /root/.3dcoin/3dcoin.conf /root
#rm /root/.3dcoin/mncache.dat
#rm /root/.3dcoin/mnpayments.dat
#printf " Restart Daemon "
#cp /root/.3dcoin/3dcoin.conf /root
rm -r /root/.3dcoin
rm /root/.3dcoin
unzip /root/BC3dcoin.zip -d /root
cp /root/3dcoin.conf /root/.3dcoin
rm /root/.3dcoin/mncache.dat
rm /root/.3dcoin/mnpayments.dat
hostname -f
#$COIN_PATH$COIN_DAEMON -daemon
printf "ALL DONE..... "
echo ""
cd 
rm *.tar* 
rm *.zip*
rm *.sh 
/usr/local/bin/3dcoind -daemon
