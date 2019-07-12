#!/bin/bash

cd /usr/local/bin
rm *.zip*
wget -q https://github.com/HologramX/Daemons/raw/master/3dcoin_latest18.zip
unzip -o -j 3dcoin_latest18.zip
ls -la

reboot &
