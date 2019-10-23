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
#*/30 * * * * /usr/local/bin/Masternode/daemon_check.sh
#0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
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

##### Main #####
clear
printf "\n"
printf "${YELLOW}#################################################################${NC}\n"
printf "${GREEN}            3DC FAST UPDATE with RESYNC   ** UBUNTU 18 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}"

cd $COIN_PATH >/dev/null 2>&1
rm *3dcoin*
rm *.zip*
cd
#UpdatePRE18
UpdateCONF
kill -9 $(pgrep $COIN_DAEMON) > /dev/null 2>&1
sleep 2
cp $CONFIG_FOLDER/$CONFIG_FILE .
rm -r $CONFIG_FOLDER
mkdir $CONFIG_FOLDER
cp $CONFIG_FILE $CONFIG_FOLDER
crontab -l > cront
printf " Restart Daemon "
hostname -f
#$COIN_PATH$COIN_DAEMON -daemon
printf "ALL DONE..... "
echo ""
cd
rm *.tar*
rm ./3dc*.sh* > /dev/null 2>&1
rm -r 3dcoin-0.14.6.1 > /dev/null 2>&1
rm -r 3dcoin-0.14.6.2 > /dev/null 2>&1
	
