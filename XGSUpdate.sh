#!/bin/bash
COIN_NAME="GenesisX"
TMP_FOLDER="/tmp"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
PURPLE="\033[0;35m"
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"
MAG="\e[1;35m"
STD="\033[0m"
echo ""
echo "*******************************"
echo "*                             *"
echo "*       XGS Masternode        *"
echo "*           UPDATE             *"
echo "*                             *"
echo "*                             *"
echo "*******************************"
echo ""
echo ""
echo ""
echo ""
nodeIpAddress=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ ${nodeIpAddress} =~ ^[0-9]+.[0-9]+.[0-9]+.[0-9]+$ ]]; then
  {
  external_ip_line="externalip=${nodeIpAddress}"
  bind_line="bind=${nodeIpAddress}:5555"
  }
else
  {
  external_ip_line="#externalip=external_IP_goes_here"
  bind_line="bind=${nodeIpAddress}:5555"
  }
fi

echo "addnode=xgs.seeds.mn.zone
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
addnode=8.12.18.113:5555" >> .genesisx/genesisx.conf

yes | apt-get update
yes | apt-get upgrade
ufw allow 5555/tcp

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
kill -9 $(pgrep genesisxd)
kill -9 $(pgrep genesisxd-shutoff)
		
wget -q https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
unzip -o -j genesisx-linux.zip -d /usr/local/bin
chmod 755 /usr/local/bin/genesis* 

cd ~
cp /root/.genesisx/genesisx.conf /root 

crontab -l > /tmp/cron2fix 
  echo "@reboot /usr/local/bin/genesisxd -daemon"  >>  /tmp/cron2fix
  crontab /tmp/cron2fix 
cd ~
rm genesisx-linux.zip
rm *.tar*
/usr/local/bin/genesisxd -daemon
rm *.sh*
