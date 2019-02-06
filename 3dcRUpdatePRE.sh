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

 
function SystemdRemove() {
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     Systemd Service REMOVE  $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
sleep 2
crontab -l > cront
systemctl stop 3dcoin
systemctl stop fire
systemctl stop mydaemon
systemctl stop tame
systemctl stop max
systemctl disable 3dcoin
systemctl disable fire
systemctl disable mydaemon
systemctl disable tame
systemctl disable max
systemctl daemon-reload
}

AutoUpdate(){
			echo ""
			echo  -e "${BLUE} Start ${Update}                    ${STD}"
			rm -f /usr/local/bin/check.sh
			rm -f /usr/local/bin/update.sh
			rm -f /usr/local/bin/UpdateNode.sh
			rm -f /usr/local/bin/cust-upd-3dc.sh
			rm -f /usr/local/bin/update_clean_reboot_auto_it.sh
			rm -f /usr/local/bin/3dcoin-cli.sh
			echo ""
			cd ~
			echo  -e "${GREEN} Get latest release                ${STD}"
			latestrelease=$(curl --silent https://api.github.com/repos/BlockchainTechLLC/3dcoin/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
			link="https://github.com/BlockchainTechLLC/3dcoin/archive/$latestrelease.zip"
			wget $link
			unzip $latestrelease.zip
			file=${latestrelease//[Vv]/3dcoin-}
			echo ""
			echo  -e "${GREEN} Stop Cron                         ${STD}" 
			sudo /etc/init.d/cron stop
			echo ""
			echo  -e "${GREEN} Install packages.....                     ${STD}"
			export LC_ALL=en_US.UTF-8
			apt-get update
			yes | apt-get install ufw python virtualenv git unzip pv nano htop libwww-perl
			yes | sudo apt-get install build-essential libtool autotools-dev autoconf automake autogen pkg-config libgtk-3-dev libssl-dev libevent-dev bsdmainutils
			yes | sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
			yes | sudo apt-get install software-properties-common 
			yes | sudo add-apt-repository ppa:bitcoin/bitcoin 
			yes | sudo apt-get update 
			yes | sudo apt-get install libdb4.8-dev libdb4.8++-dev 
			yes | sudo apt-get install libminiupnpc-dev 
			yes | sudo apt-get install libzmq3-dev
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
			yes | apt-get update			
			sleep 2
			echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
			3dcoin-cli stop
			sleep 10
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
				
			echo  -e "${GREEN} Update crontab                    ${STD}"
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
apt install unzip
localfile=\${localrelease//[Vv]/3dcoin-}
rm -rf \$localfile
link=\"https://github.com/BlockchainTechLLC/3dcoin/archive/\$latestrelease.zip\"
wget \$link
unzip \$latestrelease.zip
file=\${latestrelease//[Vv]/3dcoin-}
cd \$file
3dcoin-cli stop
sleep 10
./autogen.sh
./configure --disable-tests --disable-gui-tests --without-gui
make install-strip
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
			echo "Crontab updated successfully"
			echo ""
			echo  -e "${GREEN} Start Cron                        ${STD}"
			sudo /etc/init.d/cron start
			echo ""		
			echo  -e "${GREEN} Update Finished,rebooting server  ${STD}" 
			cd ~
			rm $latestrelease.zip 
			rm AutoUpdate.sh
			echo ""
}


##### Main #####
SystemdRemove
AutoUpdate
 
reboot
