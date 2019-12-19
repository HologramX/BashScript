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
printf "${GREEN}               3DC FAST UPDATE       ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
	echo   ""
	echo   ""
	echo "1. FAST Update ONLY DAEMON WITH PRECOMPILED Daemon for Ubuntu16"
	echo "2. FAST Update ONLY DAEMON WITH PRECOMPILED Daemon for **Ubuntu18** "	
	echo "3. FAST Update WITH PRECOMPILED Daemon and RESINK for Ubuntu16"
	echo "4. FAST Update WITH PRECOMPILED Daemon and RESINK for **Ubuntu18** "	
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
			h=$(( RANDOM % 23 + 1 ));
			echo  -e "${BLUE} Start ${Update}                    ${STD}"
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
			export LC_ALL=en_US.UTF-8
			apt-get update
			DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
			yes | apt-get install fail2ban ufw python virtualenv git unzip pv nano htop libwww-perl
			yes |  apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
			yes |  apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
			yes |  apt-get install software-properties-common 
			yes |  add-apt-repository ppa:bitcoin/bitcoin 
			yes |  apt-get update 
			yes |  apt-get install libdb4.8-dev libdb4.8++-dev 
			yes |  apt-get install libminiupnpc-dev 
			yes |  apt-get install libzmq3-dev
			yes |  apt-get install zip unzip curl
			apt-get remove apache2 -y
			apt-get remove apache2  -y
			apt-get remove apache2-bin  -y
			apt-get remove apache2-data  -y
			apt-get remove apache2-doc  -y
			apt-get remove apache2-utils  -y
			apt-get remove postfix  -y 
			apt-get autoremove -y
			apt-get autoclean -y		
			$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
			service $COIN_NAME stop > /dev/null 2>&1
			$COIN_CLI stop > /dev/null 2>&1
			sleep 8
			echo ""
			echo  -e "${GREEN} Stop Cron                         ${STD}" 
			 /etc/init.d/cron stop
}

UpdateCOMP(){
			
			echo ""
			echo  -e "${GREEN} Compiling 3Dcoin core             ${STD}"
			cd $file
			./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "Error: When Compiling 3Dcoin core" && exit;  }
			echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
			echo ""			
			3dcoin-cli stop
			sleep 2	
			echo  -e "${GREEN} Make install                      ${STD}"
			echo ""			
			make install-strip
			echo ""
}
			
			
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

UpdateCONF(){
			h=$(( RANDOM % 23 + 1 ));
			echo  -e "${GREEN} Update crontab                    ${STD}"
			cd ~
			cd /usr/local/bin
			rm -r Masternode > /dev/null 2>&1
			mkdir Masternode
			cd Masternode
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
			crontab -l >> cront
			crontab -r
line="@reboot /usr/local/bin/3dcoind
* 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/30 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh"

			echo "$line" | crontab -u root -
			echo "Crontab updated successfully"
			echo ""
			echo  -e "${GREEN} Start Cron                        ${STD}"
			 /etc/init.d/cron start
			echo ""		
			echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
			cd ~
			rm $latestrelease.tar.gz
			rm -rf $file 
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.72.203") -eq 0 ]; then
			echo "addnode=206.189.72.203" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=206.189.41.191") -eq 0 ]; then
			echo "addnode=206.189.41.191" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.197.115") -eq 0 ]; then
			echo "addnode=165.227.197.115" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=167.99.87.86") -eq 0 ]; then
			echo "addnode=167.99.87.86" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.201.222") -eq 0 ]; then
			echo "addnode=159.65.201.222" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.148.226") -eq 0 ]; then
			echo "addnode=159.65.148.226" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=165.227.38.214") -eq 0 ]; then
			echo "addnode=165.227.38.214" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.167.79") -eq 0 ]; then
			echo "addnode=159.65.167.79" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.65.90.101") -eq 0 ]; then
			echo "addnode=159.65.90.101" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=128.199.218.139") -eq 0 ]; then
			echo "addnode=128.199.218.139" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=174.138.3.33") -eq 0 ]; then
			echo "addnode=174.138.3.33" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=159.203.167.75") -eq 0 ]; then
			echo "addnode=159.203.167.75" >> /root/.3dcoin/3dcoin.conf
			fi
			if [ $(cat /root/.3dcoin/3dcoin.conf | grep -c "addnode=138.68.102.67") -eq 0 ]; then
			echo "addnode=138.68.102.67" >> /root/.3dcoin/3dcoin.conf
			fi	
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

read -p "Enter choice [ 1 - 4] " choice
case $choice in
		
	1)	echo ""
		echo " #### Update 3dcoin Daemon with PRECOMPILED DAEMON FOR UBUNTU16 ####"
		#SystemdRemove
		#PrepUpdate
		UpdatePRE16
		echo "";;
		
	2)	echo ""
		echo " #### Update 3dcoin Daemon with PRECOMPILED DAEMON FOR **UBUNTU18** ####"
		#SystemdRemove
		#PrepUpdate	
		UpdatePRE18
		echo "";;
		
	3)	echo ""
		echo " #### Update 3dcoin Daemon with PRECOMPILED DAEMON FOR UBUNTU16 ####"
		#SystemdRemove
		#PrepUpdate
		UpdatePRE16
		kill -9 $(pgrep $COIN_DAEMON) > /dev/null 2>&1
		sleep 2
		cp $CONFIG_FOLDER/$CONFIG_FILE .
		rm -r $CONFIG_FOLDER
		mkdir $CONFIG_FOLDER
		cp $CONFIG_FILE $CONFIG_FOLDER
		echo "";;
		
	4)	echo ""
		echo " #### Update 3dcoin Daemon with PRECOMPILED DAEMON FOR **UBUNTU18** ####"
		#SystemdRemove
		#PrepUpdate	
		UpdatePRE18
		kill -9 $(pgrep $COIN_DAEMON) > /dev/null 2>&1
		sleep 2
		cp $CONFIG_FOLDER/$CONFIG_FILE .
		rm -r $CONFIG_FOLDER
		mkdir $CONFIG_FOLDER
		cp $CONFIG_FILE $CONFIG_FOLDER
		echo "";;
		
	0) 	rm 3dc*.sh* > /dev/null 2>&1
		exit 0;;

	*) 	echo -e "${RED}Invalid option...${STD}" && sleep 2
esac
UpdateCONF
crontab -l > cront
printf " Restart Daemon "
hostname -f
$COIN_PATH$COIN_DAEMON -daemon
printf "ALL DONE..... "
echo ""
rm *.tar* > /dev/null 2>&1
rm ./3dc*.sh* > /dev/null 2>&1 
