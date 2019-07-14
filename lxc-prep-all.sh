#!/bin/bash

CONTAINERS=( $(pct list | grep running | awk '{print $1}') )

for CONTAINER in ${CONTAINERS[@]}
do
 
if [[ $1 =~ ^[0-9]*$ ]]; then
  if [ -d /sys/fs/cgroup/cpu/lxc/$1 ]; then
    CONTAINER=$1
    shift
    COMMAND=$@
    echo -ne "\e[1;32mexecuting \"$COMMAND\" in container #${CONTAINER} ($(grep -m 1 hostname /etc/pve/lxc/${CONTAINER}.conf | awk '{print $NF}'))\e[0m\n"
    pct exec $CONTAINER apt-get -y update
	pct exec $CONTAINER DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
	pct exec $CONTAINER apt-get -y install curl
	pct exec $CONTAINER apt-get -y install build-essential libtool autotools-dev
	pct exec $CONTAINER apt-get -y install autoconf automake autogen pkg-config 
    pct exec $CONTAINER apt-get -y install libgtk-3-dev libssl-dev libevent-dev bsdmainutils
	pct exec $CONTAINER apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev   
	pct exec $CONTAINER apt-get -y install libboost-program-options-dev libboost-test-dev libboost-thread-dev
	pct exec $CONTAINER apt-get -y install software-properties-common
    pct exec $CONTAINER add-apt-repository ppa:bitcoin/bitcoin
	pct exec $CONTAINER DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install libdb4.8-dev libdb4.8++-dev
	pct exec $CONTAINER apt-get -y install libzmq3-dev
	pct exec $CONTAINER apt-get -y install libminiupnpc-dev
		
  else
    echo -ne "\e[1;31mcontainer $1 is not running\e[0m\n"
    exit 1
  fi
fi

done
