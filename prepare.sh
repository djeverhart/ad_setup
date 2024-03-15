#!/usr/bin/bash

sudo rm -f /etc/resolv.conf
sudo sh -c 'echo "nameserver 10.8.10.100" > /etc/resolv.conf'
#sudo sh -c 'echo "10.8.10.100       cnlab.local" >> /etc/hosts'
#sudo systemctl restart systemd-resolved

#install dependencies
sudo apt update -y && sudo apt -y install git nfs-common sshpass samba dolphin cifs-utils bzip2 xz-utils curl realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
sudo mkdir /mnt/Sync

#join domain and start service
echo 'DJ&TheQu1ps' | sudo realm join -v -U Administrator cnlab.local
#manual ip specification in case dns resolution fails (it usually does, who knows)
echo 'DJ&TheQu1ps' | sudo realm join -v -U Administrator 10.8.10.100
sudo systemctl enable --now sssd

#edit pam config
cat <<EOF | sudo tee -a /etc/pam.d/common-session
session optional pam_sss.so
session required pam_mkhomedir.so
session optional pam_exec.so /opt/user.sh
EOF

#create admin group and add it to sudoers
sudo groupadd admins
echo '%admins ALL=(ALL:ALL) ALL' | sudo tee -a /etc/sudoers
echo '%admins ALL=(ALL) NOPASSWD: /bin/mount, /bin/umount' | sudo tee -a /etc/sudoers

#add truenas server to known hosts to avoid the ecdsa warning
sudo ssh-keyscan -H 10.8.10.199 >> ~/.ssh/known_hosts

#cron job for joining admins group and mounting network drive
sudo rm /opt/user.sh
sudo curl https://raw.githubusercontent.com/djeverhart/ad_setup/main/user.sh -o /opt/user.sh
sudo chmod 755 /opt/user.sh
