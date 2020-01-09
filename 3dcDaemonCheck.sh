#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root

previousBlock=$(cat /usr/local/bin/Masternode/blockcount)
currentBlock=$(3dcoin-cli getblockcount)

3dcoin-cli getblockcount > /usr/local/bin/Masternode/blockcount

if [ "$previousBlock" == "$currentBlock" ]; then
  3dcoin-cli stop
  sleep 60
  kill -9 $(pgrep 3dcoind)
  kill -9 $(pgrep 3dcoin-shutoff)
  rm -f /root/.3dcoin/banlist.dat
  rm -f /root/.3dcoin/governance.dat
  rm -f /root/.3dcoin/fee_estimates.dat
  rm -f /root/.3dcoin/mncache.dat
  rm -f /root/.3dcoin/mnpayments.dat
  rm -f /root/.3dcoin/netfulfilled.dat
  rm -f /root/.3dcoin/debug.log
  rm -f /root/.3dcoin/3dcoind.pid
  /usr/local/bin/3dcoind -reindex
fi
