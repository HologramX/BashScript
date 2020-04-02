#!/bin/bash
EDITOR=vim
choice=""
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

/usr/local/bin/3dcoin-cli stop > /dev/null 2>&1
hostname -f
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               3DC FAST MASTERNODE CONFIG         ${NC}\n"
printf "${GREEN}          Precompiled for Tiny UBUNTU 16 ${GREEN}LXC Container       ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
echo ""
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter Masternode Private key: " pv
done
echo ""
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
yes | apt-get install dnsutils
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}"
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

echo ""
echo  -e "${GREEN} Start Installation 3DCoin core                  ${STD}"
sleep 1
echo  -e "${GREEN} Install packages.....                     ${STD}"
#DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
yes | apt-get install python virtualenv git unzip pv nano htop ufw
echo ""
echo  -e "${GREEN} Firewall setup.....              ${STD}"
 ufw allow ssh/tcp
 ufw limit ssh/tcp 
 ufw allow 6695/tcp
 ufw logging on 
yes |  ufw enable 
echo ""
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
yes | apt-get install fail2ban
sleep 2
yes |  apt-get autoremove -y
yes |  apt-get autoclean -y
cd ~

echo ""
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile 
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab

echo -e "${GREEN}Downloading and Installing VPS $3dcoin Daemon${NC}"
cd /usr/local/bin/ >/dev/null 2>&1
wget -q https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
printf "\n        Downloaded Daemon" 
if [[ $? -ne 0 ]]; then
echo -e 'Error downloading node. Please contact support'
exit 1
fi
unzip -j -o /usr/local/bin/3dcoin_latest.zip
rm   /usr/local/bin/3dcoin_latest.zip
cp /usr/local/bin/3dcoind /usr/local/bin/mydaemon
mkdir /root/.3dcoin
echo "$config" > /root/.3dcoin/3dcoin.conf
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
addnode=138.68.102.67" >>  /root/.3dcoin/3dcoin.conf

cd ~
cd /usr/local/bin/
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
wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcDaemonCheck.sh
chmod 755 3dcDaemonCheck.sh
wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcUpdNodePre.sh
chmod 755 3dcUpdNodePre.sh
wget https://raw.githubusercontent.com/HologramX/BashScript/master/3dcUpdNodePre18.sh
chmod 755 3dcUpdNodePre18.sh

cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
echo "@reboot /usr/local/bin/mydaemon -daemon
1 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/30 * * * * /usr/local/bin/Masternode/3dcDaemonCheck.sh
0 $h * * * /usr/local/bin/Masternode/3dcUpdNodePre.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh
@reboot mkdir /run/sshd
@reboot mkdir /run/fail2ban
@reboot service ssh restart
@reboot service fail2ban restart" > /root/cront
crontab /root/cront
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""

#printf "Would you reboot system?"
#echo ""
#  read -p "Press [Enter] key to continue - Press [CRTL+C] key to Exit..." fackEnterKey
echo $external_ip_line
rm 3DC*.sh* > /dev/null 2>&1 && reboot
