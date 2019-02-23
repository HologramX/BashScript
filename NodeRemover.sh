#!/bin/bash
COIN_NAME=$1
CFA=$2
CONFIG_FOLDER="$HOME/.$CFA"
CONFIG_FILE="$COIN_NAME.conf"
DE="d"
COIN_DAEMON="$COIN_NAME$DE"
COIN_CLI="$COIN_NAME-cli"
COIN_PATH="/usr/local/bin/"
TMP_FOLDER="/tmp"

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'

pause(){
  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
}

printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     Node Remover for coin $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
systemctl stop $COIN_NAME
systemctl disable $COIN_NAME
systemctl daemon-reload
$COIN_CLI stop >/dev/null 2>&1
sleep 2

rm -f /usr/local/bin/$COIN_DAEMON 
rm -f /usr/local/bin/$COIN_CLI

cd ~
rm *.sh*
rm -r $CONFIG_FOLDER

crontab -l | grep "$COIN_NAME" >/dev/null 2>&1
if [[ $? -eq 0 ]]
 then 
  crontab -u root -l | grep -v '$COIN_DAEMON'  | crontab -u root -
  printf "\n        Crontab SET SUCCESFULL"
 fi
}

pause
