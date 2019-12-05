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
read -p "Please Enter Masternode Private key: " pv
done
echo ""
echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  {
  external_ip_line="externalip=${nodeIpAddress}"
  bind_line="bind=${nodeIpAddress}:8800"
  }
else
  {
  external_ip_line="#externalip=external_IP_goes_here"
  bind_line="bind=${nodeIpAddress}:8800"
  }
fi
rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')
rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
config="#----
rpcuser=$rpcUserName
rpcpassword=$rpcPassword
rpcallowip=127.0.0.1
port=8800
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
#----"

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
cd ~
ufw allow 8800/tcp 
wget https://github.com/scribenetwork/scribe/releases/download/v0.2/scribe-ubuntu-16.04-x64.tar.gz
tar -xvzf scribe-ubuntu-16.04-x64.tar.gz
cp /root/scribe-ubuntu-16.04-x64/usr/local/bin/scribe* /usr/local/bin/
cd ~
mkdir /root/.scribecore
echo "$config" > /root/.scribecore/scribe.conf
crontab -l > /tmp/cron2fix 
  echo "@reboot /usr/local/bin/scribed -daemon" /tmp/cron2fix" >>  /tmp/cron2fix
  crontab /tmp/cron2fix 
cd ~
git clone https://github.com/scribenetwork/sentinel.git && cd sentinel
virtualenv ./venv
./venv/bin/pip install -r requirements.txt

rm -r scribe-ubuntu-16.04-x64
/usr/local/bin/scribed -daemon
rm *.sh*
