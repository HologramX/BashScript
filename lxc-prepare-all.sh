#!/bin/bash

CONTAINERS=( $(pct list | grep running | awk '{print $1}') )

apt_update() {
lxc-exec $CONTAINER "apt-get update"
lxc-exec $CONTAINER "apt-get upgrade -y"
lxc-exec $CONTAINER "apt-get clean"
lxc-exec $CONTAINER "apt-get autoremove -y"
lxc-exec $CONTAINER "apt-get install build-essential -y"
lxc-exec $CONTAINER "apt-get install autotools-dev -y"
lxc-exec $CONTAINER "apt-get install autoconf -y"
lxc-exec $CONTAINER "apt-get install automake -y"
lxc-exec $CONTAINER "apt-get install autogen -y"
lxc-exec $CONTAINER "apt-get install pkg-config -y"
lxc-exec $CONTAINER "apt-get install libgtk-3-dev -y"
lxc-exec $CONTAINER "apt-get install libssl-dev -y"
lxc-exec $CONTAINER "apt-get install libevent-dev -y"
lxc-exec $CONTAINER "apt-get install bsdmainutils -y"
lxc-exec $CONTAINER "apt-get install libboost-system-dev  -y"
lxc-exec $CONTAINER "apt-get install libboost-filesystem-dev -y"
lxc-exec $CONTAINER "apt-get install libboost-chrono-dev -y"
lxc-exec $CONTAINER "apt-get install libboost-program-options-dev -y"
lxc-exec $CONTAINER "apt-get install libboost-test-dev -y"
lxc-exec $CONTAINER "apt-get install libboost-thread-dev -y"
lxc-exec $CONTAINER "apt-get install software-properties-common -y"
lxc-exec $CONTAINER "yes |  add-apt-repository ppa:bitcoin/bitcoin"
lxc-exec $CONTAINER "apt-get install libminiupnpc-dev -y"
lxc-exec $CONTAINER "apt-get install libzmq3-dev -y"
lxc-exec $CONTAINER "apt-get autoremove -y"
lxc-exec $CONTAINER "apt-get autoclean -y"

}

for CONTAINER in {101..160..1}
do
  lxc-exec $CONTAINER "which apt-get >/dev/null" && apt_update
  apt_update
done
