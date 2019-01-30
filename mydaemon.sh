#!/bin/bash
KEY=""
MIP=""

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

function Welcome(){
clear
printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                        mydaemon Fast SETUP                              ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
printf "\n        OK, WE GO.\n"
systemctl mydaemon.service stop > /dev/null 2>&1
mydaemonc stop > /dev/null 2>&1
sleep 5
rm /root/.3dcoin/* > /dev/null 2>&1
printf "\n        REMOVED old DATA" 

}

function DaemonSetup(){
printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                    SETUP mydaemon DAEMON                                   ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
  apt -y install zip unzip curl >/dev/null 2>&1
  printf "\n\n        Installed Utility" 
  cd /usr/local/bin >/dev/null 2>&1
  wget -q https://github.com/HologramX/Daemons/raw/master/mydaemon.zip
  printf "\n        Downloaded Daemon\n" 
  if [[ $? -ne 0 ]]; then
   echo -e 'Error downloading mydaemon. Please contact support'
   exit 1
  fi
  /usr/local/bin/mydaemonc stop > /dev/null 2>&1
  systemctl mydaemon.service stop > /dev/null 2>&1
  sleep 2
  unzip -j -o mydaemon.zip
  mkdir /root/.3dcoin >/dev/null 2>&1
  printf "\n        Daemon Setting DONE" 
  sleep 2
}

function ConfigfileSetup() {
printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                        Config File Setup mydaemon                          ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
MIP=($(curl -sk https://v4.ident.me/))
echo -e "${GREEN}Enter your Key${RED}"
read -e KEY
echo "rpcuser=$RPCUSER" > /tmp/configtemp 
echo "rpcpassword=$RPCPASSWORD" >> /tmp/configtemp
echo "rpcallowip=127.0.0.1
port=6695
listen=1
server=1
daemon=1
maxconnections=64
masternode=1" >> /tmp/configtemp
echo "externalip=$MIP:6695
bind=$MIP
masternodeprivkey=$KEY" >> /tmp/configtemp
echo " " >> /tmp/configtemp
cd 
rm "/root/.3dcoin/3dcoin.conf" > /dev/null 2>&1
cp /tmp/configtemp "/root/.3dcoin/3dcoin.conf"
printf "\n${NC}        Config File Succesfull Compiled"
sleep 2  
}

function FirewallSetup () {
printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                       Firewall Setup mydaemon                             ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
apt-get install ufw -y
    ufw allow ssh/tcp    #Open SSH port
    ufw limit ssh/tcp
	ufw allow 6695/tcp
    ufw logging on
    ufw -f enable
    ufw status
printf "\n        Firewall SET SUCCESFULL" 
sleep 2
}

function SystemdSetup() {
printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     Systemd Setup mydaemon                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
  cat << EOF > /etc/systemd/system/mydaemon.service
[Unit]
Description=mydaemon service
After=network.target
[Service]
User=root
Group=root
Type=forking
ExecStart=/usr/local/bin/mydaemond -daemon -conf=/root/.3dcoin/3dcoin.conf -datadir=/root/.3dcoin
ExecStop=-/usr/local/bin/mydaemonc -conf=/root/.3dcoin/3dcoin.conf -datadir=/root/.3dcoin stop
Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable mydaemon.service >/dev/null 2>&1
systemctl start mydaemon.service
sleep 8
netstat -napt | grep LISTEN | grep $MIP | grep mydaemond >/dev/null 2>&1
 if [[ $? -ne 0 ]]; then
   ERRSTATUS=TRUE
 fi
  printf "\n        mydaemon service Created, Enabled and Running" 
}

function FinalInfo() {
sleep 5
clear
 echo
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${CYAN}mydaemon linux  vps setup${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}mydaemon is up and running listening on port: ${NC}${RED}6695${NC}."
 echo -e "${GREEN}Configuration file is: ${NC}${RED}/root/.3dcoin/3dcoin.conf${NC}"
 echo -e "${GREEN}VPS_IP: ${NC}${RED}$MIP:6695${NC}"
 echo -e "${GREEN}KEY is: ${NC}${RED}$KEY${NC}"
 echo -e "${BLUE}================================================================================================================================"
 echo -e "${CYAN}Stop, start and check your mydaemon instance${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}Instance  start${NC}"
 echo -e "${GREEN}systemctl start mydaemon.service${NC}"
 echo -e "${PURPLE}Instance  stop${NC}"
 echo -e "${GREEN}systemctl stop mydaemon.service${NC}"
 echo -e "${PURPLE}Instance  check${NC}"
 echo -e "${GREEN}systemctl status mydaemon.service${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}mydaemonc mnsync status${NC}"
 echo -e "${YELLOW}It is expected this line: \"IsBlockchainSynced\": true ${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 if [[ "$ERRSTATUS" == "TRUE" ]]; then
    echo -e "${RED}mydaemon seems not running, please investigate. Check its status by running the following commands as root:${NC}"
    echo -e "systemctl status mydaemon.service"
    echo -e "${RED}You can restart it by firing following command (as root):${NC}"
    echo -e "${GREEN}systemctl start mydaemon.service${NC}"
    echo -e "${RED}Check errors by runnig following commands:${NC}"
    echo -e "${GREEN}less /var/log/syslog${NC}"
    echo -e "${GREEN}journalctl -xe${NC}"
 fi
 }


##### Main #####
Welcome
DaemonSetup
ConfigfileSetup
FirewallSetup
SystemdSetup
FinalInfo
cd
rm mydaemon.sh

if [[ -f /var/run/reboot-required ]]
  then echo -e "${RED}Warning:${NC}${GREEN}some updates require a reboot${NC}"
  echo -e "${GREEN}Do you want to reboot?${NC}"
  echo -e "${GREEN}(${NC}${RED} y ${NC} ${GREEN}/${NC}${RED} n ${NC}${GREEN})${NC}"
  read rebootsys
  case $rebootsys in
   y*)
    systemctl reboot
	;;
  esac
fi
