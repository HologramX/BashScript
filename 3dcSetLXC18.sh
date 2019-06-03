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

show_menu(){
clear
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC ORIGINAL MASTERNODE INSTALL         ${NC}\n"
printf "${GREEN}          Precompiled for ${RED}UBUNTU 18.0.4 ${GREEN}LXC Container          ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
 sleep 2   
}

Config_Masternode(){
echo ""
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
echo ""
yes | apt-get update
yes | apt-get install curl
nodeIpAddress=`curl ifconfig.me/ip`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
else
  external_ip_line="#externalip=external_IP_goes_here"
fi

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
locale-gen en_US en_US.UTF-8
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --force locales "en_US.UTF-8"
update-locale LANG=en_US.UTF-8
update-locale LANGUAGE=en:us:en
echo $LOCALE > /etc/default/locale
echo "export LANG=en_US.UTF-8" >> ~/.bashrc
echo "export LANGUAGE=en:us:en" >> ~/.bashrc
echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" >> ~/.bashrc

h=$(( RANDOM % 23 + 1 ));
echo ""
echo  -e "${GREEN} Install packages.....                     ${STD}"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
yes | apt-get install python virtualenv git unzip pv nano htop 
echo ""
#echo  -e "${GREEN} Firewall setup.....              ${STD}"
# ufw allow ssh/tcp
# ufw limit ssh/tcp 
# ufw allow 6695/tcp
# ufw logging on 
#yes |  ufw enable 
#echo ""
echo  -e "${GREEN} Clone GIT for NEXT UPDATE OF 3dcoin core.....     ${STD}"
rm -rf /usr/local/bin/Masternode
yes |  apt-get update
yes |  apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
yes |  apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
yes |  apt-get install software-properties-common
yes |  add-apt-repository ppa:bitcoin/bitcoin
yes |  apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install libdb4.8-dev libdb4.8++-dev
yes |  apt-get install libminiupnpc-dev
yes |  apt-get install libzmq3-dev
sleep 2
rm -v /etc/ssh/ssh_host_*
dpkg-reconfigure -u openssh-server
#yes |  apt-get remove openssh-server
yes |  apt-get remove apache2 -y
yes |  apt-get remove apache2  -y
yes |  apt-get remove apache2-bin  -y
yes |  apt-get remove apache2-data  -y
yes |  apt-get remove apache2-doc  -y
yes |  apt-get remove apache2-utils  -y
yes |  apt-get remove postfix  -y 
yes |  apt-get autoremove -y
yes |  apt-get autoclean -y
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.tar.gz"
wget $link
tar -xvzf $latestrelease.tar.gz
file=${latestrelease//[v]/3dcoin-}
sleep 2
}

install_3dcoin_core_PRE(){
echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
apt -y install zip unzip >/dev/null 2>&1
printf "\n\n         Installed Utility" 
cd 
cd $COIN_PATH >/dev/null 2>&1
wget -q $COIN_TGZ
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
unzip -j -o $COIN_ZIP
$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
service $COIN_NAME stop > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1
sleep 2
  
}

install_3dcoin_core_PRE18(){
echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
apt -y install zip unzip >/dev/null 2>&1
printf "\n\n         Installed Utility" 
cd 
cd $COIN_PATH >/dev/null 2>&1
wget -q $COIN_TGZ18
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
unzip -j -o $COIN_ZIP18
$COIN_PATH$COIN_CLI stop > /dev/null 2>&1
service $COIN_NAME stop > /dev/null 2>&1
$COIN_CLI stop > /dev/null 2>&1
sleep 2
 
}


config_3dcoin_core(){
echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir $CONFIG_FOLDER
echo "$config" > "$CONFIG_FOLDER/$CONFIG_FILE"
cd ~
cd $COIN_PATH
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
line="@reboot /usr/local/bin/3dcoind -daemon
0 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
#*/10 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */2 * * /usr/local/bin/Masternode/clearlog.sh"
echo "$line" | crontab -u root -
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""
cd ~
rm $latestrelease.tar.gz
rm -rf $file 
}

show_menu
echo ""
echo " #### 3Dcoin Masternode installation Original with Compilation ####"
Config_Masternode
prep_3dcoin_core
install_3dcoin_core_PRE18
config_3dcoin_core
rm 3dc*.sh* > /dev/null 2>&1
rm .3dcoin/mncache.dat > /dev/null 2>&1
rm .3dccoin/mnpayments.dat > /dev/null 2>&1
printf "Would you reboot system?"
echo ""
pause
reboot

