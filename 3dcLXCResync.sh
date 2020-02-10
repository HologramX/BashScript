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

kill -9 $(pgrep $COIN_DAEMON)
cp $CONFIG_FOLDER/$CONFIG_FILE .
rm -r $CONFIG_FOLDER
unzip -o BC3dcoin.zip 
cp $CONFIG_FILE $CONFIG_FOLDER
rm *.sh && reboot
