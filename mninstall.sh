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
echo '   ______                                         _'
echo '  / ____/___  ____ ___  ____ ___  ___  __________(_)_  ______ ___'
echo ' / /   / __ \/ __ `__ \/ __ `__ \/ _ \/ ___/ ___/ / / / / __ `__ \'
echo '/ /___/ /_/ / / / / / / / / / / /  __/ /  / /__/ / /_/ / / / / / /'
echo '\____/\____/_/ /_/ /_/_/ /_/ /_/\___/_/   \___/_/\__,_/_/ /_/ /_/'
echo ''
echo ''
echo 'Welcome to the commercium automatic masternode installing script v 0.0.01'
echo '                                                     by Sennevb'
echo '-------------------------------------------------------------------------'
echo ''
echo 'This installation may take several minutes depending on the speed of your vps'
echo 'During instalaltion some feedback is asked from you'
read -p 'Ready ? Press ENTER to proceed'
#----------------------------------------------------------#
#                      Checking swap                       #
#----------------------------------------------------------#
clear
echo ''
echo '   ______                                         _'
echo '  / ____/___  ____ ___  ____ ___  ___  __________(_)_  ______ ___'
echo ' / /   / __ \/ __ `__ \/ __ `__ \/ _ \/ ___/ ___/ / / / / __ `__ \'
echo '/ /___/ /_/ / / / / / / / / / / /  __/ /  / /__/ / /_/ / / / / / /'
echo '\____/\____/_/ /_/ /_/_/ /_/ /_/\___/_/   \___/_/\__,_/_/ /_/ /_/'
echo ''
echo ''
echo 'Welcome to the commercium automatic masternode installing script v 0.0.01'
echo '                                                     by Sennevb'
echo '-------------------------------------------------------------------------'
echo ''
echo 'Step 1 of ? - Checking if your system has enough memory, if not we are going to add some swap space'
echo '-------------------------------------------------------------------------------------------------------'
# Checking swap on small instances
if [ -z "$(swapon -s)" ] && [ $memory -lt 800000 ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
    echo "==> progress: we added 4GB of swap to your vps server to speedup your vps"
else
   echo "==> progress : Server has enough memory or allready has some swap space, no swap added"
fi



#install all the needed dependencies
#sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev


#todo: install 



