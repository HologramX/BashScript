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
LOCALE="LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANGUAGE=en:it:en"


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

$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
#service $COIN_NAME stop > /dev/null 2>&1
#$COIN_CLI stop > /dev/null 2>&1
hostname -f
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC FAST MASTERNODE CONFIG         ${NC}\n"
printf "${GREEN}          Precompiled for ${RED}UBUNTU 18.0.4 ${GREEN}LXC Container       ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
echo ""
#cat ~/.3dcoin/3dcoin.conf | grep privkey > pk
#cp "$CONFIG_FOLDER/$CONFIG_FILE" .


echo ""
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="#externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

#rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')
#rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
rpcuser=APrKMTuvTQVw
rpcpassword=dAIRc9EkYB9MUG11V2FNamZRLyxXyVHV
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=32
#----
masternode=1
$external_ip_line
#----
masternodeprivkey=$pv
#----"

rm -v /etc/ssh/ssh_host_* >/dev/null 2>&1
#dpkg-reconfigure -u openssh-server
#yes |  apt-get remove openssh-server
cd ~

#echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
#cd $COIN_PATH >/dev/null 2>&1
#wget -q $COIN_TGZ18
#printf "\n        Downloaded Daemon" 
#if [[ $? -ne 0 ]]; then
#echo -e 'Error downloading node. Please contact support'
#exit 1
#fi
#unzip -j -o
#rm  $COIN_ZIP18
#killall -9 3dcoind >/dev/null 2>&1

echo "$config" > "$CONFIG_FOLDER/$CONFIG_FILE"
#cat pk >> "$CONFIG_FOLDER/$CONFIG_FILE"
echo "#---
addnode=206.189.72.203
addnode=206.189.41.191
addnode=165.227.197.115
addnode=167.99.87.86
addnode=159.65.201.222
addnode=159.65.148.226
addnode=165.227.38.214
addnode=159.65.167.79
addnode=159.65.90.101
addnode=128.199.218.139
addnode=174.138.3.33
addnode=159.203.167.75
addnode=138.68.102.67" >>  "$CONFIG_FOLDER/$CONFIG_FILE"

#cd ~
#cd $COIN_PATH
#mkdir Masternode
#cd Masternode
#rm -f *
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Check-scripts.sh
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Update-scripts.sh
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/UpdateNode.sh
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/clearlog.sh
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/daemon_check.sh
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/Version
#wget https://raw.githubusercontent.com/BlockchainTechLLC/masternode/master/Masternode/blockcount
#chmod 755 daemon_check.sh
#chmod 755 UpdateNode.sh
#chmod 755 Check-scripts.sh
#chmod 755 Update-scripts.sh
#chmod 755 clearlog.sh

cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
line="@reboot /usr/local/bin/3dcoind -daemon
1 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
#*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh"
echo "$line" | crontab -u root -
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""

rm -f /root/.3dcoin/banlist.dat
rm -f /root/.3dcoin/mncache.dat
rm -f /root/.3dcoin/mnpayments.dat
rm -f /root/.3dcoin/netfulfilled.dat
date > /root/.3dcoin/debug.log
rm -f /root/.3dcoin/3dcoind.pid
#printf "Would you reboot system?"
#echo ""
#  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
rm 3dc*.sh* > /dev/null 2>&1 && reboot
