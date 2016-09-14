#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
touch /tmp/pistation-install.log
echo "---START---\r\n" > /tmp/pistation-install.log
printf "${GREEN}PiStation Installer v1.0.0 (log in ${RED}/tmp/pistation-install.log${GREEN})${NC}\r\n"
printf "\r\n"
printf "   ${GREEN}Creating directories...${NC}\r\n"
mkdir /var/pistation >> /tmp/pistation-install.log 2>&1
chown pi /var/pistation >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Setting locale...${NC}\r\n"
echo "Europe/Amsterdam" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Updating packages (this might take a while)...${NC}\r\n"
apt-get update >> /tmp/pistation-install.log 2>&1
apt-get upgrade -y >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing required packages (this might take a while.. as well)...${NC}\r\n"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> /tmp/pistation-install.log 2>&1
apt-get install nodejs git htop g++ -y >> /tmp/pistation-install.log 2>&1
npm install typings ts-node typescript --global >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Downloading PiStation sourcecode...${NC}\r\n"
sudo -i -u pi git clone https://github.com/PiStation/pistation-api.git /var/pistation/pistation-api >> /tmp/pistation-install.log 2>&1
sudo -i -u pi git clone https://github.com/PiStation/pistation-client.git /var/pistation/pistation-client >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing dependencies...${NC}\r\n"

sudo -H -u pi bash -c 'cd /var/pistation/pistation-api; npm install; typings install'  >> /tmp/pistation-install.log 2>&1
sudo -H -u pi bash -c 'cd /var/pistation/pistation-client; npm install; typings install'  >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing WiringPi...${NC}\r\n"
git clone git://git.drogon.net/wiringPi /var/wiringPi >> /tmp/pistation-install.log 2>&1
cd /var/wiringPi >> /tmp/pistation-install.log 2>&1
git pull origin >> /tmp/pistation-install.log 2>&1
./build >> /tmp/pistation-install.log 2>&1