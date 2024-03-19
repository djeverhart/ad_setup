#!/usr/bin/bash

sudo apt update -y && sudo apt install git wget python3 python3-pip -y
sudo pip3 install python-pam

cd /opt/
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/compile.sh
sudo chmod +x compile.sh
sudo ./compile.sh
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/prepare.sh
sudo shc -f prepare.sh
sudo chmod +x /prepare.sh.x
sudo rm /opt/test.log
sudo ./prepare.sh.x
