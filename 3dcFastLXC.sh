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
service $COIN_NAME stop > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC FAST MASTERNODE CONFIG         ${NC}\n"
printf "${GREEN}          Precompiled for ${RED}UBUNTU 18.0.4 ${GREEN}LXC Container          ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"

echo ""
hostname -f
cat ~/.3dcoin/3dcoin.conf | grep privkey > pk
echo ""
#unset pv
#while [ -z ${pv} ]; do
#read -p "Please Enter Masternode Private key: " pv
#done
#echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="#externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi
masternode_priv_line="masternodeprivkey=${pv}"

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=32
#----
masternode=1

$external_ip_line
#----"
#masternodeprivkey=$pv
rm -v /etc/ssh/ssh_host_* >/dev/null 2>&1
#dpkg-reconfigure -u openssh-server
#yes |  apt-get remove openssh-server
cd ~

#echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
#printf "\n\n         Installed Utility" 
#cd 
#cd $COIN_PATH >/dev/null 2>&1
#wget -q $COIN_TGZ18
#printf "\n        Downloaded Daemon" 
#if [[ $? -ne 0 ]]; then
#echo -e 'Error downloading node. Please contact support'
#exit 1
#fi
#unzip -j -o
#rm  $COIN_ZIP18
killall -9 3dcoind >/dev/null 2>&1
cp "$CONFIG_FOLDER/$CONFIG_FILE" .
echo "$config" > "$CONFIG_FOLDER/$CONFIG_FILE"
cat pk >> "$CONFIG_FOLDER/$CONFIG_FILE"

rm -f /root/.3dcoin/banlist.dat
rm -f /root/.3dcoin/mncache.dat
rm -f /root/.3dcoin/mnpayments.dat
rm -f /root/.3dcoin/netfulfilled.dat
rm -f /root/.3dcoin/debug.log
rm -f /root/.3dcoin/3dcoind.pid
date > .3dcoin/debug.log
rm -r 3dcoin-0* > /dev/null 2>&1
rm *.tar* > /dev/null 2>&1
rm pk > /dev/null 2>&1
# /usr/local/bin/3dcoind -daemon &
rm 3dc*.sh* > /dev/null 2>&1
