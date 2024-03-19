#!/usr/bin/bash

sudo apt update -y && sudo apt install git wget python3 python3-pip -y
sudo pip3 install python-pam

cd /opt/
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/compile.sh
sudo chmod +x compile.sh
sudo ./compile.sh
sudo rm /opt/user.sh.x
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/prepare.sh
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/user.sh

sudo shc -f prepare.sh
sudo chmod +x /prepare.sh.x
sudo rm prepare.sh.x.c
sudo shc -f user.sh
sudo chmod 755 user.sh.x
sudo rm user.sh.x.c
sudo rm /opt/test.log
sudo ./prepare.sh.x
sudo rm /opt/4.0.3.zip
sudo rm -rf /opt/shc-4.0.3
sudo rm compile.sh
sudo rm prepare.sh
sudo rm user.sh
sudo rm prepare.sh.x
