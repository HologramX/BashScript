  
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
STD='\033[0m'
MAG='\e[1;35m'

 
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}                     $COIN DESTUCK by REINDEX  $COIN_NAME                               ${NC}\n"
printf "${YELLOW}#########################################################################${NC}\n"

$COIN_PATH$COIN_CLI stop
sleep 10
rm -f $HOME/.$FOLDER/banlist.dat
rm -f $HOME/.$FOLDER/mncache.dat
rm -f $HOME/.$FOLDER/mnpayments.dat
rm -f $HOME/.$FOLDER/fee_estimates.dat
rm -f $HOME/.$FOLDER/netfulfilled.dat
rm -f $HOME/.$FOLDER/governance.dat
rm -f $HOME/.$FOLDER/debug.log
rm -f $HOME/.$FOLDER/3dcoind.pid
cd ~
cd $COIN_PATH
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

cd ~
crontab -l > cron
h=$(( RANDOM % 23 + 1 ));
crontab -r
echo "@reboot /usr/local/bin/3dcoind -daemon
1 0 * * * /usr/local/bin/Masternode/Check-scripts.sh
*/30 * * * * /usr/local/bin/Masternode/daemon_check.sh
0 $h * * * /usr/local/bin/Masternode/UpdateNode.sh
* * */7 * * /usr/local/bin/Masternode/clearlog.sh" > cront
crontab /root/cront
echo  -e "${GREEN} 3DCoin core Configured successfully .....               ${STD}"
echo ""
rm *.sh*

reboot
#$COIN_PATH$COIN_DAEMON -reindex
