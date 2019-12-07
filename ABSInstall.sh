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
unset pv
while [ -z ${pv} ]; do
read -p "Please Enter ABSOLUTE Masternode Private key: " pv
done
echo ""
echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
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
addnode=139.99.41.241:18888
addnode=139.99.41.242:18888
addnode=139.99.202.1:18888
"

yes | apt-get update
yes | apt-get upgrade

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
ufw allow 18888/tcp 
wget https://github.com/absolute-community/absolute/releases/download/v12.2.5/absolutecore-0.12.2.5-x86_64-linux-gnu.tar.gz
tar -xvzf absolutecore-0.12.2.5-x86_64-linux-gnu.tar.gz
cp /root/absolutecore-0.12.2.5/bin/absolute* /usr/local/bin/
cd ~
mkdir /root/.absolutecore
echo "$config" > /root/.absolutecore/absolutecore.conf
crontab -l > /tmp/cron2fix 
  echo "@reboot /usr/local/bin/absoluted -daemon"  >>  /tmp/cron2fix
  echo "* * * * * cd /root/.absolutecore/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >>  /tmp/cron2fix
  crontab /tmp/cron2fix 
cd ~
apt-get -y -qq install python
apt-get -y -qq install python-virtualenv
apt-get install git -y -qq
cd /root/.absolutecore
git clone https://github.com/absolute-community/sentinel.git --q
cd /root/.absolutecore/sentinel
virtualenv ./venv
./venv/bin/pip install -r requirements.txt
echo "absolute_conf=/root/.absolutecore/absolute.conf" >> /root/.absolutecore/sentinel/sentinel.conf
cd ~
rm -r absolutecore-0.12.2.5
rm *.tar*
/usr/local/bin/absoluted -daemon
rm *.sh* 
