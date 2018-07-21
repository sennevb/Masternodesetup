#!/bin/bash
# Commercium Automatic Masternode installation script - Ubuntu
# by sennevb - htpps://pool.miningspeed.com

#----------------------------------------------------------#
#                  Variables                               #
#----------------------------------------------------------#
memory=$(grep 'MemTotal' /proc/meminfo |tr ' ' '\n' |grep [0-9])
arch=$(uname -i)
os='ubuntu'

#----------------------------------------------------------#
#                   Installation Info                      #
#----------------------------------------------------------#
clear
echo ''
echo'   _____                                        _      '            
echo'  / ____|                                      (_)      '           
echo' | |     ___  _ __ ___  _ __ ___   ___ _ __ ___ _ _   _ _ __ ___'   
echo' | |    / _ \| '_ ` _ \| '_ ` _ \ / _ \ '__/ __| | | | | '_ ` _ \'  
echo' | |___| (_) | | | | | | | | | | |  __/ | | (__| | |_| | | | | | |' 
echo'  \_____\___/|_| |_| |_|_| |_| |_|\___|_|  \___|_|\__,_|_| |_| |_| '
echo ''
echo 'Welcome to the commercium automatic masternode installing script v 0.0.01'
echo '                                                     by Sennevb'
echo '-------------------------------------------------------------------------'

                                                                   
#----------------------------------------------------------#
#                      Checking swap                       #
#----------------------------------------------------------#

# Checking swap on small instances
if [ -z "$(swapon -s)" ] && [ $memory -lt 800000 ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
fi


#install all the needed dependencies
#sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev


#todo: install 



