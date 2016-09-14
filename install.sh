#!/bin/bash
mkdir /var/pistation
chown pi /var/pistation
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git nodejs npm node-semver -y
git clone git@github.com:PiStation/pistation-api.git /var/pistation/pistation-api
git clone git@github.com:PiStation/pistation-client.git /var/pistation/pistation-client