#!/bin/bash
EDITOR=vim
COIN_NAME="scribe"
TMP_FOLDER="/tmp"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'
echo ""
echo "*******************************"
echo "*                             *"
echo "*       XGS Masternode        *"
echo "*           SETUP             *"
echo "*                             *"
echo "*                             *"
echo "*******************************"
echo ""
echo ""
genesis-cli stop > /dev/null 2>&1
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter GenesisX Masternode Private key: " pv
done
echo ""
echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  external_ip_line="externalip=${nodeIpAddress}:5555"
else
  external_ip_line="#externalip=external_IP_goes_here:5555"
fi
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  bind_line="masternodeaddr=${nodeIpAddress}:5555"
else
  external_ip_line="#masternodeaddr=external_IP_goes_here:5555"
fi

rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')
rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
rpcport=18889
port=18888
#----
listen=1
server=1
daemon=1
maxconnections=32
#----
masternode=1
$bind_line
$external_ip_line
#----
masternodeprivkey=$pv
#----
addnode=xgs.seeds.mn.zone
addnode=xgs.mnseeds.com
addnode=144.202.51.218:5555
addnode=108.61.132.146:5555
addnode=66.42.113.222:5555
addnode=108.61.179.198:5555
addnode=206.189.227.156:5555
addnode=155.138.207.17:5555
addnode=5.189.163.30:5555
addnode=213.227.154.56:5555
addnode=23.106.215.65:5555
addnode=155.138.207.17:5555
addnode=45.76.3.217:5555
addnode=8.12.18.113:5555

"

yes | apt-get update
yes | apt-get upgrade
yes | apt-get install wget nano unrar unzip 
yes | apt-get install libboost-all-dev libevent-dev software-properties-common 
yes | add-apt-repository ppa:bitcoin/bitcoin 
yes | apt-get install libdb4.8-dev libdb4.8++-dev 
yes | apt-get install libpthread-stubs0-dev 
yes | apt-get install libzmq3-dev 
yes | apt install make build-essential libtool software-properties-common autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev \
libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git curl libdb4.8-dev \
bsdmainutils libdb4.8++-dev libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev libdb5.3++ unzip libzmq5
yes | apt-get install -y ufw
yes | ufw allow ssh/tcp
yes | ufw limit ssh/tcp
yes | ufw allow 5555/tcp
yes | ufw logging on
yes | ufw enable

yes |  apt-get remove apache2 -y
yes |  apt-get remove apache2  -y
yes |  apt-get remove apache2-bin  -y
yes |  apt-get remove apache2-data  -y
yes |  apt-get remove apache2-doc  -y
yes |  apt-get remove apache2-utils  -y
yes |  apt-get remove postfix  -y 
yes |  apt-get autoremove -y
yes |  apt-get autoclean -y
yes |  apt-get install python-virtualenv
apt-get install pwgen  -y -qq
apt-get install tmux  -y -qq
apt-get install libevent-pthreads-2.0-5 -y -qq
cd ~
kill -9 $(pgrep genesisxd)
kill -9 $(pgrep genesisxd-shutoff)
		
wget -q https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
tar --overwrite -C /usr/local/bin/ -zxf .\genesisx-linux.zip

cd ~
mkdir /root/.genesisx
echo "$config" > /root/.genesisx/genesisx.conf
crontab -l > /tmp/cron2fix 
  echo "@reboot /usr/local/bin/genesisxd -daemon"  >>  /tmp/cron2fix
  crontab /tmp/cron2fix 
cd ~
rm -r genesisx-linux.zip
rm *.tar*
/usr/local/bin/genesisxd -daemon
rm *.sh* 