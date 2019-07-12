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

#clear
$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
cp .$COIN_NAME/$COIN_NAME.conf .
/usr/local/bin/3dcoin-cli stop
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}     Node Preparer  for ${RED}UBUNTU 18.0.4 ${GREEN}LXC Container ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
 sleep 2   

echo ""
#DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --force locales "en_US.UTF-8"

echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
#DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
#yes | apt-get install python virtualenv git unzip pv nano htop 
#rm -v /etc/ssh/ssh_host_*
#yes | apt-get install openssh-server
#echo ""
#DEBIAN_FRONTEND=noninteractive apt-get -y update 
#DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
#DEBIAN_FRONTEND=noninteractive apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
#DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
#yes |  add-apt-repository ppa:bitcoin/bitcoin
#DEBIAN_FRONTEND=noninteractive apt-get -y update
#DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install libdb4.8-dev libdb4.8++-dev
#DEBIAN_FRONTEND=noninteractive apt-get -y install libminiupnpc-dev
#DEBIAN_FRONTEND=noninteractive apt-get -y install libzmq3-dev
#apt-get -y remove openssh-server
#DEBIAN_FRONTEND=noninteractive apt-get -y autoremove 
#DEBIAN_FRONTEND=noninteractive apt-get -y autoclean 
#cd ~
#apt-get -y install curl
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
wget $link
tar -xvzf $latestrelease.tar.gz
file=${latestrelease//[v]/3dcoin-}
sleep 2

echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
apt -y install zip unzip >/dev/null 2>&1
printf "\n\n         Installed Utility" 
cd 
cd $COIN_PATH >/dev/null 2>&1
rm *.zip*
wget -q $COIN_TGZ18
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
unzip -j -o $COIN_ZIP18

cd ~
cd $COIN_PATH
mkdir Masternode
cd Masternode
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
#crontab -l >> cron
#h=$(( RANDOM % 23 + 1 ));
#crontab -r
#line="@reboot /usr/local/bin/3dcoind -daemon
#0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
#*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
#0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
#* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
#echo "$line" | crontab -u root -
#echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
#echo ""
#cd ~
rm $latestrelease.tar.gz
rm $file 
rm 3dc*.sh* > /dev/null 2>&1
rm .3dcoin/mncache.dat > /dev/null 2>&1
#rm .3dccoin/mnpayments.dat > /dev/null 2>&1
printf "Rebooting"
#echo ""
#  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
hostname -f
reboot &
