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
choice=""
NODE_IP=""
COIN_TGZ=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest.zip
COIN_ZIP="3dcoin_latest.zip"
COIN_TGZ18=https://github.com/HologramX/Daemons/raw/master/3dcoin_latest18.zip
COIN_ZIP18="3dcoin_latest18.zip"

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'
STD='\033[0m'
	
##### Main #####
printf "\n"
printf "\n"
printf "\n"
printf "\n"
printf "${YELLOW}#################################################################${NC}\n"
printf "${GREEN}            3DC FAST UPDATE  ** UBUNTU 18 **         ${NC}\n"
printf "${YELLOW}###################################################################${NC}"
cd ~
echo "addnode=89.40.127.40
addnode=80.211.106.106
addnode=93.186.254.217
addnode=80.211.197.58
addnode=80.211.216.64
addnode=81.2.249.48
addnode=81.2.253.84
addnode=194.182.85.236
addnode=80.211.117.147
addnode=80.211.83.145
addnode=80.211.28.173
addnode=212.237.50.243
addnode=212.237.63.198
addnode=80.211.101.38
addnode=212.237.62.63
addnode=80.211.187.152
addnode=80.211.173.236
addnode=80.211.87.148
addnode=212.237.18.20
addnode=80.211.94.158
addnode=80.211.239.135
addnode=80.211.0.236
addnode=80.211.56.67
addnode=80.211.134.11
addnode=80.211.2.60
addnode=80.211.92.142
addnode=80.211.153.53
addnode=80.211.87.253
addnode=80.211.67.167
addnode=80.211.115.246
addnode=80.211.115.52
addnode=80.211.115.173
addnode=80.211.42.35
addnode=188.213.175.235
addnode=80.211.103.230
addnode=80.211.186.153
addnode=94.177.189.190
addnode=212.237.25.133
addnode=80.211.151.193
addnode=94.177.216.28
addnode=80.211.75.95
addnode=80.211.75.114
addnode=80.211.86.123
addnode=80.211.86.7
addnode=80.211.85.231
addnode=80.211.86.108
addnode=80.211.86.209
addnode=80.211.165.55
addnode=80.211.14.103
addnode=80.211.168.64
addnode=80.211.172.249
addnode=80.211.42.165
addnode=80.211.98.233
addnode=77.81.230.126
addnode=80.211.101.200
addnode=217.61.6.233
addnode=217.61.110.85
addnode=206.189.72.203
addnode=206.189.41.191
addnode=165.227.197.115
addnode=167.99.87.86
addnode=159.65.201.222
addnode=159.65.148.226
addnode=165.227.38.214
addnode=159.65.167.79
addnode=159.65.90.101
addnode=128.199.218.139
addnode=174.138.3.33
addnode=159.203.167.75
addnode=138.68.102.67" >> .3dcoin/3dcoin.conf
rm *.sh
