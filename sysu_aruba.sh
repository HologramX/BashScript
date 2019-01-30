#!/bin/bash
RED='\033[1;31m'
GREEN='\033[00;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root

printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                   SYSTEM Upgrade/Update e Clean                        ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
apt-get update
apt-get remove apache2 -y
apt-get remove apache2  -y
apt-get remove apache2-bin  -y
apt-get remove apache2-data  -y
apt-get remove apache2-doc  -y
apt-get remove apache2-utils  -y
apt-get remove postfix  -y 
apt-get upgrade -y
#apt-get dist-upgrade -y
apt-get update
apt-get autoremove -y
apt-get autoclean -y
printf "\n        System Setup SUCCESFULL"

printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                   FIREWALL Setup                        ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
apt-get install ufw -y
    ufw allow ssh/tcp    #Open SSH port
    ufw limit ssh/tcp
    ufw logging on
    ufw -f enable
    ufw status
printf "\n        Firewall SET SUCCESFULL"

printf "\n\n\n\n\n\n\n\n\n\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                   Utility Setup                        ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n\n"
sleep 2
apt-get install fail2ban -y
apt-get install nano -y
apt-get install unzip -y
apt-get install zip -y
apt-get install curl -y 
wget https://github.com/HologramX/BashScript/raw/master/jail.local > /dev/null 2>&1
cp -rf ./jail.local /etc/fail2ban/ > /dev/null 2>&1
systemctl restart fail2ban.service > /dev/null 2>&1
printf "\n        Utility Installed "


printf "\n\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${RED}#                   SYSTEM REBOOT                                       # ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
# choose if reboot
if [[ -f /var/run/reboot-required ]]
  then echo -e "${RED}Warning:${NC}${GREEN}some updates require a reboot${NC}"
fi
printf "${RED}\nWould you reboot system? (Y/N)"
read -n 1 -r
echo    # (optional) move to a new line
# auto update masternode
if [[ $REPLY =~ ^[Yy]$ ]]; then
systemctl reboot
else
printf "${YELLOW}\nDONE\n"
printf "${NC}\n"
fi
