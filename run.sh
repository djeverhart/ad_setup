#!/usr/bin/bash

sudo apt update -y && sudo apt install git -y
cd /opt/
sudo git clone https://raw.githubusercontent.com/djeverhart/ad_setup/main/prepare.sh
cd prepare
sudo chmod +x prepare.sh
sudo ./prepare.sh
