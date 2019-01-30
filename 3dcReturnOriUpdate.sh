#!/bin/bash
EDITOR=vim
COIN_NAME="3dcoin"
FOLDER="3dcoin"
CONFIG_FOLDER="$HOME/.$FOLDER"
CONFIG_FILE="$COIN_NAME.conf"
DE="d"
COIN_DAEMON="$COIN_NAME$DE"
COIN_CLI="$COIN_NAME-cli"
COIN_PATH="/usr/local/bin/"

BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m' 
PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
MAG='\e[1;35m'

 
function SystemdRemove() {
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     Systemd Service REMOVE  $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"
sleep 2
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
			echo  -e "${GREEN} Stop 3Dcoin core                  ${STD}"
			3dcoin-cli stop
			sleep 10
			echo ""		
			echo  -e "${GREEN} Make install                      ${STD}"
			cd $file
			./autogen.sh
			./configure --disable-tests --disable-gui-tests --without-gui
			make install-strip
			sleep 10
			echo ""
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
			reboot
			echo ""
}


##### Main #####
SystemdRemove
AutoUpdate
