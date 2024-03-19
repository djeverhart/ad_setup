#!/usr/bin/bash

sudo wget https://github.com/neurobin/shc/archive/refs/tags/4.0.3.zip
sudo unzip 4.0.3.zip
cd shc-4.0.3/
sudo ./configure
make
sudo make install

sudo rm /opt/user.sh.x
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/prepare.sh
sudo wget https://raw.githubusercontent.com/djeverhart/ad_setup/main/user.sh
sudo shc -f prepare.sh
sudo chmod +x prepare.sh.x
sudo rm prepare.sh.x.c
sudo shc -f user.sh
sudo chmod 755 user.sh.x
sudo rm user.sh.x.c
sudo rm /opt/test.log

sudo rm /opt/4.0.3.zip
sudo rm -rf /opt/shc-4.0.3
sudo rm /opt/run.sh
sudo rm /opt/prepare.sh
sudo rm /opt/user.sh
sudo rm /opt/prepare.sh.x

cd /opt/
sudo ./prepare.sh.x
sudo rm "$0"
