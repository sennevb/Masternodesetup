#!/bin/bash
# Commercium Automatic Masternode installation script - Ubuntu
# by sennevb - htpps://pool.miningspeed.com
ip=`ip route get 8.8.8.8 | awk 'NR==1 {print $NF}'`

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
echo 'Step 1 of 4 - Checking if your system has enough memory, if not we are going to add some swap space'
echo '-------------------------------------------------------------------------------------------------------'
# Checking swap on small instances
if [ -z "$(swapon -s)" ] && [ $memory -lt 8000000 ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
    echo "==> progress: we added 4GB of swap to your vps server to speedup your vps"
else
   echo "==> progress : Server has enough memory or allready has some swap space, no swap added"
  sleep 3
fi

#----------------------------------------------------------#
#        Upgrading system - install dependencies           #
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
echo 'Step 2 of 4 - Installing dependencies / Fail2ban / Firewall'
echo '-------------------------------------------------------------------------------------------------------'

# Update system
echo ''
echo ''
echo "Upgrading system..."
sleep 3
sudo apt-get -y update

# Install fail2ban 
if [ $(dpkg-query -W -f='${Status}' fail2ban 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    echo && echo "Installing fail2ban..."
    sleep 3
    sudo apt-get -y install fail2ban
    sudo service fail2ban restart 
    echo && echo "Fail2ban installed and active..."
    sleep 3
else	
   echo && echo "Fail2ban allready installed.. skipping."	
   sleep 3	
fi

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
echo 'Step 2 of 4 - Installing dependencies / Fail2ban / Firewall'
echo '-------------------------------------------------------------------------------------------------------'
# Install firewall if needed
    echo && echo "Installing UFW..."
    sleep 3
    sudo apt-get -y install ufw
    echo && echo "Configuring UFW..."
    sleep 3
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw limit ssh
    sudo ufw allow 12018/tcp
    echo "y" | sudo ufw enable
    echo && echo "Firewall installed and enabled!"
    sleep 3

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
echo 'Step 2 of 4 - Installing dependencies / Fail2ban / Firewall'
echo '-------------------------------------------------------------------------------------------------------'
   echo && echo "Installing dependencies, hold your horses...."
   echo
sudo apt-get install software-properties-common -y
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev -y
sudo apt-get install libminiupnpc-dev libzmq3-dev  libqrencode-dev libdb4.8-dev libdb4.8++-dev -y
echo && echo "Yay everything installed! party!!"
sleep 3
clear
echo && echo "All dependencies installed... proceeding to next step."
sleep 3 



#----------------------------------------------------------#
#                  Installing Commercium                   #
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
echo 'Step 3 of 4 - installing Commercium and setting up as a service'
echo '-------------------------------------------------------------------------------------------------------'
echo && echo "Adding new user called apostille..."
# Add masternode group and user
sudo groupadd apostille
sudo useradd -m -g apostille apostille

#downloading, unpacking and copying to /usr/local/bin
echo && echo "Downloading Commercium..."
sleep 3
#wipe older version if allreayd downloaded
rm -rf commercium-TESTNET-0.16.0-bin-linux.tar.gz
#donwload new one
wget https://github.com/CommerciumBlockchain/Commercium-TESTNET/releases/download/TESTNET-0.16.0/commercium-TESTNET-0.16.0-bin-linux.tar.gz
echo && echo "Unpacking Commercium..."
echo
tar -xzvf commercium-TESTNET-0.16.0-bin-linux.tar.gz
echo && echo "Chmod Commercium and copying it to /usr/local/bin..."
echo
cd commercium-TESTNET-0.16.0-bin-linux
sudo chmod +x commerciumd
sudo chmod +x commercium-cli 
sudo cp commercium{d,-cli} /usr/local/bin
echo && echo "Done! proceeding to next step..."
sleep 3

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
echo ' ------------------------------------------------------------------------'
echo '|                                                                        |'
echo '| We are halfway, but need your action now!                              |'
echo '|                                                                        |'
echo '| 1. Open your full node desktop wallet on your desktop                  |'
echo '| 2. Navigate to menu Tools -> Debug Console                             |'
echo '| 3. Run the following command: getnewaddress                            |'
echo '| 4. Send 10000MNM in a single transaction to the address returned       |'
echo '| 5. Navigate to menu Tools -> Debug Console again                       |'
echo '| 6. Run the following command: masternode genkey                        |'
echo '|    It should return a long string that starts with 5                   |'
echo '|    5xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                      |'
echo '|    This is your MASTERNODE PRIVATE KEY                                 |'
echo '|                                                                        |'
echo '| 7. Keep this key safe, note it down, enter it in the next step         |'
echo ' ------------------------------------------------------------------------'

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
echo 'Step 3 of 4 - installing Commercium and setting up as a service'
echo '-------------------------------------------------------------------------------------------------------'
while [[ "$key" == "" ]]; do
	read -e -p "Enter masternode key generated in previous step (e.g. 5edfjLCUzGczZi3JQw8GHp434R9kNY33eFyMGeKRymkB56G4324h) : " key
	       if [[ "$key" == "" ]]; then
		echo "WARNING: No private key entered, retrying!!!"
		sleep 3
              fi
done

echo && echo "Configuring commerciumd..."
sleep 3
rpcuser=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
rpcpassword=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
sudo mkdir -p /home/apostille/.commerciumcore
sudo touch /home/apostille/.commerciumcore/commercium.conf
echo '
rpcuser='$rpcuser'
rpcpassword='$rpcpassword'
rpcallowip=127.0.0.1
listen=1
server=1
daemon=0 # required for systemd
txindex=1
externalip='$ip':12018
masternodepaddr='$ip':12018
masternodeprivkey='$key'
masternode=1
addnode=zcash.ph:12018
addnode=testnet.cmm.cm:12018
addnode=krad.commercium.net:12018
' | sudo -E tee /home/apostille/.commerciumcore/commercium.conf
sudo chown -R apostille:apostille /home/apostille/.commerciumcore

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
echo 'Step 3 of 4 - installing Commercium and setting up as a service'
echo '-------------------------------------------------------------------------------------------------------'

# Setup systemd service
echo && echo "Setting up Commercium Daemon..."
sleep 3
sudo touch /etc/systemd/system/commerciumd.service
echo '[Unit]
Description=commerciumd
After=network.target

[Service]
Type=simple
User=apostille
WorkingDirectory=/home/apostille
ExecStart=/usr/local/bin/commerciumd -conf=/home/apostille/.commerciumcore/commercium.conf -datadir=/home/apostille/.commerciumcore
ExecStop=/usr/local/bin/commercium-cli -conf=/home/apostille/.commerciumcore/commercium.conf -datadir=/home/apostille/.commerciumcore stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
' | sudo -E tee /etc/systemd/system/commerciumd.service
echo && echo "Setup done!"
sleep 3
echo && echo "Starting Commercium Daemon..."
sudo systemctl enable commerciumd
sudo systemctl start commerciumd
sleep 3

# Add alias to run commercium-cli
echo && echo "Masternode setup complete!"
touch ~/.bash_aliases
echo "alias commercium-cli='commercium-cli -conf=/home/apostille/.commerciumcore/commercium.conf -datadir=/home/apostille/.commerciumcore'" | tee -a ~/.bash_aliases


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
echo 'Step 4 of 4 - Setting up node desktop wallet'
echo ' ----------------------------------------------------------------------------------------------------'
echo '|                                                                                                     |'
echo '| Almost there, please finish these final step:                                                       |'
echo '|                                                                                                     |'
echo '| 1. Open your full node desktop wallet on your desktop                                               |'
echo '| 2. Navigate to menu Tools -> Debug Console                                                          |'
echo '| 3. Run the following command: masternode outputs                                                    |'
echo '| 4. You should see output like the following if you have a                                           |'
echo '|    transaction with exactly 10000 CMM:                                                              |'
echo '|    {\"12345678xxxxxxxxxxxxxxx\": \"0\"}                                                             |'
echo '|                                                                                                     |'
echo '|    The value on the left is your txid and the right is the vout                                     |'
echo '|                                                                                                     |'
echo '| 5. Go to menu Settings -> Options -> check the [Show Masternode Tab]                                |'
echo '| 6. Go to menu Tools -> Open Masternode Configuration File                                           |'
echo '|    Add a line to the bottom of the file with the following format:                                  |'
echo '|                                                                                                     |'
echo '|    alias vps_ip :port       masternode_private_key                                tx_id        vout |'
echo '|    mn1   '$ip':12018 '$key '123456xxxxxxxx   0 |'
echo '|                                                                                                     |'
echo '| 7. Save the file, exit your wallet and reopen your wallet.                                          |'
echo ' -----------------------------------------------------------------------------------------------------'
echo && echo
echo "********************************************************************************"
echo "* Congratulation! Your setup is completed.                                     *"
echo "*                                                                              *"
echo "* please run: source ~/.bash_aliases                                           *"
echo "*                                                                              *"
echo "* Now you can run commercium-cli masternode status                             *"
echo "*                                                                              *"
echo "* Your datadir is /home/apostille/.commerciumcore                              *"
echo "* Useful command: sudo systemctl status commerciumd                            *"
echo "*                 sudo systemctl restart commerciumd                           *"
echo "*                 sudo systemctl start commerciumd                             *"
echo "********************************************************************************"
