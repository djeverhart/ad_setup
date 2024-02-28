#!/usr/bin/bash

sudo apt update -y && sudo apt install git wget -y
cd /opt/
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/prepare.sh
sudo chmod +x prepare.sh
sudo ./prepare.sh
