#!/bin/bash
EDITOR=vim
COIN_NAME="3dcoin"
FOLDER="3dcoin"
CONFIG_FOLDER="$HOME/.$FOLDER"
CONFIG_FILE="$COIN_NAME.conf"
DE="d"
COIN_DAEMON="$COIN_NAME$DE"
COIN_CLI="$COIN_NAME-cli"
COIN_PATH="/usr/local/bin/"

BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m' 
PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
STD='\033[0m'
MAG='\e[1;35m'

 
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     $COIN DESTUCK by RESYNK  $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root

currentBlock=$(3dcoin-cli masternode count)

if [ "$currentBlock" != 0 ] then exit

kill -9 $(pgrep $COIN_DAEMON)
cd /root
cp /root/.3dcoin/3dcoin.conf /root/3dcoin.conf 
rm -r /root/.3dcoin
mkdir /root/.3dcoin
cp /root/3dcoin.conf /root/.3dcoin/3dcoin.conf 
$COIN_PATH$COIN_DAEMON -daemon
rm *.sh
