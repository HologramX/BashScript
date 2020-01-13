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
printf "${GREEN}            3DC FAST UPDATE  ** UBUNTU 18 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}"
cd ~
cd /usr/local/bin/Masternode
rm -f *
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Check-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Update-scripts.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/UpdateNode.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/clearlog.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/daemon_check.sh
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Version
wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/blockcount
chmod 755 daemon_check.sh
chmod 755 UpdateNode.sh
chmod 755 Check-scripts.sh
chmod 755 Update-scripts.sh
chmod 755 clearlog.sh
cd ~
crontab -l >> cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
line="@reboot /usr/local/bin/3dcoind -daemon
0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/30 * * * * /usr/local/bin/Masternode/daemon_check.sh
#0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
echo "$line" | crontab -u root -
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""
echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
cd 
cd $COIN_PATH >/dev/null 2>&1
#wget -q $COIN_TGZ
#printf "\n        Downloaded Daemon" 
#if [[ $? -ne 0 ]]; then
#echo -e 'Error downloading node. Please contact support'
#exit 1
#fi
$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
service $COIN_NAME stop > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1
sleep 10
kill -9 $(pgrep 3dcoind)
kill -9 $(pgrep 3dcoin-shutoff)
unzip -o -j $COIN_ZIP
rm *.zip*

cd /root
cp $CONFIG_FOLDER/$CONFIG_FILE .
rm /root/.3dcoin/mncache.dat
rm /root/.3dcoin/mnpayments.dat
date > /root/.3dcoin/debug.log
hostname -f
printf "ALL DONE..... "
rm *.tar*
rm 3DC*.sh && reboot
