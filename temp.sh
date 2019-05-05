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

 
/usr/local/bin/3dcoin-cli stop 
/usr/local/bin/mydaemonc - stop

cp /usr/local/bin/3dcoind /usr/local/bin/mydaemond
cp /usr/local/bin/3dcoin-cli /usr/local/bin/mydaemonc

rm .3dcoin/mncache.dat
rm .3dcoin/mnpaayment.dat

/usr/local/bin/mydaemond -daemon

