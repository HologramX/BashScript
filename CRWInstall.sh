#!/bin/bash
# Copyright (c) 2018 The Crown developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# Usage: ./crown-server-install.sh [OPTION]...
#
# Setup crown server or update existing one

LATEST_RELEASE="0.13.2.0"
dir=/tmp
systemnode=false
masternode=false
help=false
install=false
unknown=()
appname=$(basename "$0")


handle_arguments()
{

clear
printf "\n"
printf "${YELLOW}#########################################################################${NC}\n"
printf "${GREEN}               CROWM MASTERNODE INSTALL         ${NC}\n"
printf "${YELLOW}#########################################################################${NC}"
	echo   ""
	echo   ""
	echo "1. Install Masternode "
	echo "2. Install Systemnode "
	echo "0. Exit"
	echo ""
   
  read -p "Enter choice [ 1 - 6] " choice
        case $choice in
            1) masternode=true
                echo "";;
            2)  systemnode=true
                echo "";;
            0) 	exit 0;;	

			*) 	echo -e "${RED}Invalid option...${STD}" && sleep 2
        esac
      
}

install_dependencies() {
    sudo apt-get install curl ufw unzip -y
}

create_swap() {
    if [ `sudo swapon | wc -l` -lt 2 ]; then
        sudo mkdir -p /var/cache/swap/   
        sudo dd if=/dev/zero of=/var/cache/swap/myswap bs=1M count=1024
        sudo chmod 600 /var/cache/swap/myswap
        sudo mkswap /var/cache/swap/myswap
        sudo swapon /var/cache/swap/myswap
        swap_line='/var/cache/swap/myswap   none    swap    sw  0   0'
        # Add the line only once 
        sudo grep -q -F "$swap_line" /etc/fstab || echo "$swap_line" | sudo tee --append /etc/fstab > /dev/null
        cat /etc/fstab
    fi
}

update_repos() {
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
}

download_package() {
    # Create temporary directory
    if [ -z "$dir" ]; then
        # Create directory under $HOME if above operation failed
        dir=$HOME/crown-temp
        mkdir -p $dir
    fi
    # 32 or 64 bit? If getconf fails we'll assume 64
    BITS=$(getconf LONG_BIT 2>/dev/null)
    if [ $? -ne 0 ]; then
       BITS=64
    fi
    # Change this later to take latest release version.
    wget "https://github.com/Crowndev/crowncoin/releases/download/v0.13.2.0/Crown-$LATEST_RELEASE-Linux64.zip" -O $dir/crown.zip
}

install_package() {
    sudo unzip -d $dir/crown $dir/crown.zip
    cp -f $dir/crown/bin/* /usr/local/bin/
    cp -f $dir/crown/lib/* /usr/local/lib/
}

configure_conf() {
    cd $HOME
    mkdir -p .crown
    sudo mv .crown/crown.conf .crown/crown.bak
    touch .crown/crown.conf
    IP=$(curl http://checkip.amazonaws.com/)
    PW=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c32;echo;)
    echo "==========================================================="
    pwd
	unset privkey
    while [ -z ${privkey} ]; do
    read -p "Please Enter Masternode Private key: " privkey
    done
    echo ""
    echo "daemon=1" > .crown/crown.conf 
    echo "rpcallowip=127.0.0.1" >> .crown/crown.conf 
    echo "rpcuser=crowncoinrpc">> .crown/crown.conf 
    echo "rpcpassword="$PW >> .crown/crown.conf 
    echo "listen=1" >> .crown/crown.conf 
    echo "server=1" >>.crown/crown.conf 
    echo "externalip="$IP >>.crown/crown.conf 
    if [ "$systemnode" = true ] ; then
        echo "systemnode=1" >>.crown/crown.conf
        echo "systemnodeprivkey="$privkey >>.crown/crown.conf
    elif [ "$masternode" = true ] ; then
        echo "masternode=1" >>.crown/crown.conf
        echo "masternodeprivkey="$privkey >>.crown/crown.conf
    fi
    cat .crown/crown.conf
}

configure_firewall() {
    sudo ufw allow ssh/tcp
    sudo ufw limit ssh/tcp
    sudo ufw allow 9340/tcp
    sudo ufw logging on
    sudo ufw --force enable
}

add_cron_job() {
    cron_line="@reboot /usr/local/bin/crownd"
    if [ `crontab -l 2>/dev/null | grep "$cron_line" | wc -l` -eq 0 ]; then
        (crontab -l 2>/dev/null; echo "$cron_line") | crontab -
    fi
}

main() {
    # (Quietly) Stop crownd (in case it's running)
    /usr/local/bin/crown-cli stop 2>/dev/null
    # Update Repos
    update_repos
    # Install dependencies
    install_dependencies
    # Download the latest release
    download_package
    # Extract and install
    install_package

    if [ "$install" = true ] ; then
        # Create swap to help with sync
        create_swap
        # Create folder structures and configure crown.conf
        configure_conf
        # Configure firewall
        configure_firewall
    fi

    # Ensure there is a cron job to restart crownd on reboot
    add_cron_job
    # Start Crownd to begin sync
    #/usr/local/bin/crownd
}

handle_arguments 
main
