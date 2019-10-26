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

kill -9 $(pgrep 3dcoind)
kill -9 $(pgrep make)
kill -9 $(pgrep g++)
kill -9 $(pgrep cc1plus)
cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
echo "@reboot /usr/local/bin/3dcoind -daemon
1 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
#*/30 * * * * /usr/local/bin/Masternode/daemon_check.sh
#0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh" > cront
crontab /root/cront

cd /usr/local/bin
unzip -o -j $COIN_ZIP
rm *.zip*
cd
kill -9 $(pgrep $COIN_DAEMON) > /dev/null 2>&1
sleep 2
cp $CONFIG_FOLDER/$CONFIG_FILE .
rm -r $CONFIG_FOLDER
mkdir $CONFIG_FOLDER
cp $CONFIG_FILE $CONFIG_FOLDER
crontab -l > cront
unzip -o -j BC3dcoin.zip
printf " Restart Daemon "
hostname -f
$COIN_PATH$COIN_DAEMON -daemon
printf "ALL DONE..... "
echo ""
cd
rm *.tar* > /dev/null 2>&1
rm ./3dc*.sh* > /dev/null 2>&1
rm -r 3dcoin-0.14.6.1 > /dev/null 2>&1
rm -r 3dcoin-0.14.6.2 > /dev/null 2>&1
