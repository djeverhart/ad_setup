#!/usr/bin/bash

sudo mkdir -P /tmp/shc
cd /tmp/shc
sudo wget https://github.com/neurobin/shc/archive/refs/tags/4.0.3.zip
sudo unzip 4.0.3.zip
cd shc-4.0.3/
sudo ./configure
make
sudo make install
