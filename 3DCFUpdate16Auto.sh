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
	
			
UpdatePRE16(){
	echo ""
	echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
	cd 
	cd $COIN_PATH >/dev/null 2>&1
	wget -q $COIN_TGZ
	printf "\n        Downloaded Daemon" 
	if [[ $? -ne 0 ]]; then
	echo -e 'Error downloading node. Please contact support'
	exit 1
	fi
	$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
	service $COIN_NAME stop > /dev/null 2>&1
	$COIN_CLI stop > /dev/null 2>&1
	sleep 10
	unzip -o -j $COIN_ZIP
	rm *.zip*
}

UpdatePRE18(){
	echo ""
	echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
	cd 
	cd $COIN_PATH >/dev/null 2>&1
	wget -q $COIN_TGZ18
	printf "\n        Downloaded Daemon" 
	if [[ $? -ne 0 ]]; then
	echo -e 'Error downloading node. Please contact support'
	exit 1
	fi	
	$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
	service $COIN_NAME stop > /dev/null 2>&1
	$COIN_CLI stop > /dev/null 2>&1
	sleep 10
	unzip -o -j $COIN_ZIP18
	rm *.zip*
}


##### Main #####
clear
printf "\n"
printf "${YELLOW}#################################################################${NC}\n"
printf "${GREEN}            3DC FAST UPDATE  ** UBUNTU 18 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}"

cd ~
cd /usr/local/bin/Masternode
rm UpdateNode.sh
rm 3dcUpdNodePre*
rm 3dcDaemonCheck*
wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcUpdNodePre.sh
wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcDaemonCheck.sh
#wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcUpdNodePre18.sh
#mv ./3dcUpdNodePre18.sh ./3dcUpdNodePre.sh
chmod 755 3dcUpdNodePre.sh
chmod 755 3dcDaemonCheck.sh


cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
echo "@reboot /usr/local/bin/3dcoind -daemon
#1 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/30 * * * * /usr/local/bin/Masternode/3dcDaemonCheck.sh
0 $h * * * /usr/local/bin/Masternode/3dcUpdNodePre.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh" > /root/cront
crontab /root/cront
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""


UpdatePRE16
#UpdatePRE18
cd /root
cp $CONFIG_FOLDER/$CONFIG_FILE .
crontab -l > cron
kill -9 $(pgrep 3dcoind)
kill -9 $(pgrep 3dcoin-shutoff)
rm -r $CONFIG_FOLDER
mkdir $CONFIG_FOLDER
cp $CONFIG_FILE $CONFIG_FOLDER
hostname -f
printf "ALL DONE..... "
echo ""
rm *.tar*
apt-get -f -y install
apt-get install perl -y
apt-get --purge autoremove -y
apt-get clean
apt-get autoclean -y
rm -r 3dcoin
rm -r 3dcoin-0.14.1.2
rm -r 3dcoin-0.14.6.1
rm -r 3dcoin-0.14.6.2
rm -r 3dcoin-0.15.0.1
rm -r dynamic-2.3.5
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
/usr/local/bin/3dcoind -daemon
rm *.sh*
