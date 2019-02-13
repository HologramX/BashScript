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
NODE_IP=""
COIN_TGZ=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
COIN_ZIP="3dcoin_latest.zip"

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'
MAG='\e[1;35m'


pause(){
  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
}

show_menu() {
clear
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC ORIGINAL MASTERNODE INSTALL         ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
	echo   ""
	echo   ""
	echo "1. Install Masternode - COMPILING"
	echo "2. Install Masternode - PRECOMPILED"
	echo "3. Install Masternode - PRECOMPILED (OpenVZ FIX)"
	echo "4. Exit"
	echo ""
   
}


Config_Masternode(){
nodeIpAddress=`curl ifconfig.me/ip`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')

rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done

config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
masternode=1
masternodeprivkey=$pv
$external_ip_line
#----
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
addnode=138.68.102.67"
}

prep_3dcoin_core(){
echo ""
echo  -e "${GREEN} Start Installation 3DCoin core                  ${STD}"
sleep 1
h=$(( RANDOM % 23 + 1 ));
echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
yes | apt-get update
yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
echo ""
echo  -e "${GREEN} Firewall/Swapfile setup.....              ${STD}"
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp 
sudo ufw allow 6695/tcp
sudo ufw logging on 
yes | sudo ufw enable 
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile 
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
sleep 2 
echo ""
echo  -e "${GREEN} Building 3dcoin core from source.....     ${STD}"
rm -rf /usr/local/bin/Masternode
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
wget $link
tar -xvzf $latestrelease.tar.gz
file=${latestrelease//[v]/3dcoin-}
yes | sudo apt-get update
export LC_ALL=en_US.UTF-8
yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes | sudo apt-get install software-properties-common
yes | sudo add-apt-repository ppa:bitcoin/bitcoin
yes | sudo apt-get update
yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev
yes | sudo apt-get install libminiupnpc-dev
yes | sudo apt-get install libzmq3-dev
yes | apt-get install sshpass
sleep 2
yes | sudo apt-get remove apache2 -y
yes | sudo apt-get remove apache2  -y
yes | sudo apt-get remove apache2-bin  -y
yes | sudo apt-get remove apache2-data  -y
yes | sudo apt-get remove apache2-doc  -y
yes | sudo apt-get remove apache2-utils  -y
yes | sudo apt-get remove postfix  -y 
yes | sudo apt-get upgrade -y
yes | sudo apt-get update
yes | sudo apt-get autoremove -y
yes | sudo apt-get autoclean -y
sleep 2
}

install_3dcoin_core_COMP()
{

echo ""
echo  -e "${GREEN} Compile 3dcoin core .....                 ${STD}"
cd $file
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make || { echo "Error: When Compiling 3Dcoin core" && exit;  }
3dcoin-cli stop > /dev/null 2>&1
echo  -e "${GREEN} Make install                              ${STD}"
echo ""			
make install-strip
echo ""
}

install_3dcoin_core_PRE()
{
echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
apt -y install zip unzip curl >/dev/null 2>&1
printf "\n\n         Installed Utility" 
cd 
cd $TMP_FOLDER >/dev/null 2>&1
wget -q $COIN_TGZ
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
unzip -j $COIN_ZIP
$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
service $COIN_NAME stop > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1
sleep 2
cp $COIN_DAEMON $COIN_PATH 
cp $COIN_CLI $COIN_PATH     
}

config_3dcoin_core()
{
echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir ./.3dcoin
echo "$config" > ./.3dcoin/3dcoin.conf
cd ~
cd /usr/local/bin
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
crontab -r
line="@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
echo "$line" | crontab -u root -
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""
cd ~
rm $latestrelease.tar.gz
rm -rf $file 
}

openvz_fix ()
{
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

show_menu()
local choice
read -p "Enter choice [ 1 - 4] " choice
case $choice in
		
	#### 3Dcoin Masternode installation Original with Compilation
	1)	echo ""
		echo " #### 3Dcoin Masternode installation Original with Compilation ####"
		Config_Masternode
		prep_3dcoin_core()
		install_3dcoin_core_COMP()	
		config_3dcoin_core()
		exit 0;;

	#### 3Dcoin Masternode installation Original with PRECOMPILED Daemon
	2)	echo ""
		echo " #### 3Dcoin Masternode installation Original with PRECOMPILED DAEMON ####"
		Config_Masternode
		prep_3dcoin_core()	
		install_3dcoin_core_PRE()
		config_3dcoin_core()
		exit 0;;

	#### 3Dcoin Primenode installation
	3)	echo ""
		echo " #### 3Dcoin Masternode installation Original with PRECOMPILED DAEMON and OPENVZ FIX####"
		Config_Masternode
		prep_3dcoin_core()	
		install_3dcoin_core_PRE()
		config_3dcoin_core()
		openvz_fix
		exit 0;;

	4) 	exit 0;;

	*) 	echo -e "${RED}Invalid option...${STD}" && sleep 2
esac

echo  -e "${GREEN} Rebooting .....               ${STD}"
reboot