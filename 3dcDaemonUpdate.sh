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

pause(){
  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
}


show_menu(){
clear
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC ORIGINAL MASTERNODE INSTALL         ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
	echo   ""
	echo   ""
	echo "1. Update Masternode - ** PRECOMPILED ** Daemon - Ubuntu16"
	echo "2. Update Masternode - ** PRECOMPILED ** Daemon - Ubuntu16 - OpenVZ FIX"
	echo "3. Update Masternode - ** PRECOMPILED ** Daemon - **Ubuntu18**"
	echo "4. Update Masternode - ** PRECOMPILED ** Daemon - **Ubuntu18** - OpenVZ FIX"
	echo "0. Exit"
	echo ""
   
}


SystemdRemove() {
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     Systemd Service REMOVE  $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
sleep 2
systemctl stop 3dcoin
systemctl stop fire
systemctl stop mydaemon
systemctl stop tame
systemctl stop max
systemctl disable 3dcoin
systemctl disable fire
systemctl disable mydaemon
systemctl disable tame
systemctl disable max
systemctl daemon-reload
}

PrepUpdate(){

			echo ""
			echo  -e "${BLUE} Start ${Update}                    ${STD}"
			rm -f /usr/local/bin/check.sh
			rm -f /usr/local/bin/update.sh
			rm -f /usr/local/bin/UpdateNode.sh
			rm -f /usr/local/bin/cust-upd-3dc.sh
			rm -f /usr/local/bin/update_clean_reboot_auto_it.sh
			rm -f /usr/local/bin/3dcoin-cli.sh
			rm -rf /usr/local/bin/Masternode
			echo ""
			echo  -e "${GREEN} Install packages.....                     ${STD}"
			apt-get update
			DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
			apt-get autoremove -y
			apt-get autoclean -y		
			sleep 2
			$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
			service $COIN_NAME stop > /dev/null 2>&1
			$COIN_CLI stop > /dev/null 2>&1
			sleep 2
			echo ""
			cd ~
			echo  -e "${GREEN} Get latest release                ${STD}"
			latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
			link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
			wget $link
			tar -xvzf $latestrelease.tar.gz
			file=${latestrelease//[Vv]/3dcoin-} 
			echo ""
			echo  -e "${GREEN} Stop Cron                         ${STD}" 
			 /etc/init.d/cron stop
}

UpdatePRE16(){
	echo ""
	echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
	cd 
	cd $TMP_FOLDER >/dev/null 2>&1
	wget -q $COIN_TGZ
	printf "\n        Downloaded Daemon" 
	if [[ $? -ne 0 ]]; then
	echo -e 'Error downloading node. Please contact support'
	exit 1
	fi
	unzip -o -j $COIN_ZIP
	$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
	service $COIN_NAME stop > /dev/null 2>&1
	$COIN_CLI stop > /dev/null 2>&1
	sleep 2
	cp $COIN_DAEMON $COIN_PATH 
	cp $COIN_CLI $COIN_PATH 
}

UpdatePRE18(){
	echo ""
	echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
	cd 
	cd $TMP_FOLDER >/dev/null 2>&1
	wget -q $COIN_TGZ18
	printf "\n        Downloaded Daemon" 
	if [[ $? -ne 0 ]]; then
	echo -e 'Error downloading node. Please contact support'
	exit 1
	fi
	unzip -o -j $COIN_ZIP18
	$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
	service $COIN_NAME stop > /dev/null 2>&1
	$COIN_CLI stop > /dev/null 2>&1
	sleep 2
	cp $COIN_DAEMON $COIN_PATH 
	cp $COIN_CLI $COIN_PATH 
}

OpenvzFix(){
crontab -l | grep "/run/sshd" >/dev/null 2>&1
if [[ $? -eq 0 ]]
 then printf "\n        Crontab already SET"
  else crontab -l > /tmp/cron2fix 
  echo "@reboot mkdir /run/sshd" >> /tmp/cron2fix 
  echo "@reboot mkdir /run/fail2ban" >> /tmp/cron2fix 
  echo "@reboot service sshd start" >> /tmp/cron2fix
  echo "@reboot service fail2ban start" >> /tmp/cron2fix
  crontab /tmp/cron2fix 
  printf "\n        Crontab SET SUCCESFULL"
 fi
}

##### Main #####
show_menu

read -p "Enter choice [ 1 - 5] " choice
case $choice in
		
	1)	echo ""
		echo "## 3Dcoin Masternode Daemon UPDATE with PRECOMPILED DAEMON - U16 ##"
		SystemdRemove
		PrepUpdate
		UpdatePRE16
		echo "";;

	2)	echo ""
		echo "## 3Dcoin Masternode Daemon UPDATE with PRECOMPILED DAEMON - U16 - FIX ##"
		SystemdRemove
		PrepUpdate
		UpdatePRE16
		OpenvzFix
		echo "";;

	3)	echo ""
		echo "## 3Dcoin Masternode Daemon UPDATE with PRECOMPILED DAEMON - U18 - FIX ##"
		SystemdRemove
		PrepUpdate
		UpdatePRE18
		echo "";;
		
	4)	echo ""
		echo "## 3Dcoin Masternode Daemon UPDATE with PRECOMPILED DAEMON - U18 - FIX ##"
		SystemdRemove
		PrepUpdate
		UpdatePRE18
		OpenvzFix
		echo "";;
		
	0) 	rm 3dc*.sh* > /dev/null 2>&1
		exit 0;;

	*) 	echo -e "${RED}Invalid option...${STD}" && sleep 2
esac
printf "ALL DONE rebooting system..... "
rm 3dc*.sh* > /dev/null 2>&1
pause
reboot
