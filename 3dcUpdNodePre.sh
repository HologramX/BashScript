#!/bin/bash

TMP_FOLDER="/tmp"
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
LOGFILE='/usr/local/bin/Masternode/update.log'
dt=`date '+%d/%m/%Y %H:%M:%S'`

##### Main #####
clear
printf "\n"
printf "${YELLOW}#################################################################${NC}\n"
printf "${GREEN}            3DC FAST UPDATE  ** UBUNTU 16 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}\n\n"

latestrelease=$(curl --silent https://raw.githubusercontent.com/HologramX/BashScript/master/3dcversion | grep '"version":' | sed -E 's/.*"([^"]+)".*/\1/')
localrelease=$(3dcoin-cli -version | awk -F' ' '{print $NF}' | cut -d "-" -f1)
if [ -z "$latestrelease" ] || [ "$latestrelease" == "$localrelease" ]; then 
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: There is no New Update latest release is $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
exit;
else
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: Starting Update 3DCoin core to $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE

cd ~
3dcoin-cli stop
sleep 10
kill -9 $(pgrep 3dcoind)
kill -9 $(pgrep 3dcoin-shutoff)
	echo ""
	echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
	cd 
	cd /usr/local/bin/ >/dev/null 2>&1
	wget -q https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
	printf "\n        Downloaded Daemon" 
	if [[ $? -ne 0 ]]; then
	echo -e 'Error downloading node. Please contact support'
	exit 1
	fi
	unzip -o -j 3dcoin_latest.zip
	rm *.zip*
	cd /root
	printf "ALL DONE..... Rebooting "
	echo ""
	rm *.tar*
	kill -9 $(pgrep 3dcoind)
	kill -9 $(pgrep 3dcoin-shutoff)
	rm /root/.3dcoin/mncache.dat
	rm /root/.3dcoin/mnpayments.dat
reboot
fi
