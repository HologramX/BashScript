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

printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC ORIGINAAL MASTERNODE INSTALL (Precompiled)        ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
sleep 2

#### 3Dcoin Masternode installation
2) type="Masternode"

echo  -e "${GREEN} Get RPC Data                      ${STD}"
sleep 1

unset ip
while [ -z ${ip} ]; do
read -p "Please Enter VPS Ip: " ip
done

unset username
while [ -z ${username} ]; do
read -p "Please Enter RPC User: " username
done

unset pass
while [ -z ${pass} ]; do
read -s -p "Please Enter RPC Password: " pass
echo ""
done

unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
		
config="#----
rpcuser=$username
rpcpassword=$pass
rpcallowip=127.0.0.1
#----
listen=1
server=1
daemon=1
maxconnections=64
#----
masternode=1
masternodeprivkey=$pv
externalip=$ip
#----"

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
echo "Firewall/Swapfile setup successfully"
echo ""
echo  -e "${GREEN} Building 3dcoin core from source.....     ${STD}"
cd ~
latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.zip"
wget $link
unzip $latestrelease.zip
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
sleep 2
echo ""
echo  -e "${GREEN} Compile 3dcoin core .....                 ${STD}"
#cd $file
#./autogen.sh
#./configure --disable-tests --disable-gui-tests --without-gui
#make install-strip
#echo ""
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
sleep 2

echo  -e "${GREEN} Configure 3dcoin core .....               ${STD}"
cd ~
mkdir ./.3dcoin
echo "$config" >> ./.3dcoin/3dcoin.conf
cd ~
echo "#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestrelease=\$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')
localrelease=\$(3dcoin-cli -version | awk -F' ' '{print \$NF}' | cut -d \"-\" -f1)
if [ -z \"\$latestrelease\" ] || [ \"\$latestrelease\" == \"\$localrelease\" ]; then
exit;
else
cd ~
localfile=\${localrelease//[v]/3dcoin-}
rm -rf \$localfile
link=\"https://github.com/BlockchainTechLLC/3dcoin/archive/\$latestrelease.zip\"
wget \$link
unzip \$latestrelease.zip
file=\${latestrelease//[v]/3dcoin-}
cd \$file
3dcoin-cli stop
sleep 10
./autogen.sh && ./configure --disable-tests --disable-gui-tests --without-gui && make install-strip;
cd ~
rm \$latestrelease.zip
reboot
fi" >> /usr/local/bin/UpdateNode.sh
cd ~
cd /usr/local/bin
chmod 755 UpdateNode.sh
cd ~
crontab -r
line="@reboot /usr/local/bin/3dcoind
0 0 * * * /usr/local/bin/UpdateNode.sh"
echo "$line" | crontab -u root -
echo "3DCOIN Configured successfully"
echo ""
cd ~
rm $latestrelease.zip
reboot

