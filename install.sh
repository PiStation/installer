#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
touch /tmp/pistation-install.log
printf "${GREEN}PiStation Installer v1.0.0 (log in ${RED}/tmp/pistation-install.log${GREEN})${NC}\r\n"
printf "\r\n"
printf "   ${GREEN}Creating directories...${NC}\r\n"
mkdir /var/pistation >> /tmp/pistation-install.log 2>&1
chown pi /var/pistation >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Updating packages (this might take a while)...${NC}\r\n"
apt-get update && sudo apt-get upgrade -y >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing required packages (this might take a while.. as well)...${NC}\r\n"
apt-get install git nodejs npm node-semver -y >> /tmp/pistation-install.log 2>&1
npm install typings ts-node --global >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Downloading PiStation sourcecode...${NC}\r\n"
git clone https://github.com/PiStation/pistation-api.git /var/pistation/pistation-api >> /tmp/pistation-install.log 2>&1
git clone https://github.com/PiStation/pistation-client.git /var/pistation/pistation-client >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing dependencies...${NC}\r\n"
cd /var/pistation/pistation-api
npm install >> /tmp/pistation-install.log 2>&1
typings install >> /tmp/pistation-install.log 2>&1

cd /var/pistation/pistation-client
npm install >> /tmp/pistation-install.log 2>&1
typings install >> /tmp/pistation-install.log 2>&1

printf "   ${GREEN}Installing WiringPi...${NC}\r\n"
git clone git://git.drogon.net/wiringPi /var/wiringPi >> /tmp/pistation-install.log 2>&1
cd /var/wiringPi >> /tmp/pistation-install.log 2>&1
git pull origin >> /tmp/pistation-install.log 2>&1
./build >> /tmp/pistation-install.log 2>&1