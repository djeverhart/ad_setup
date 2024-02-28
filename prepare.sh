#!/usr/bin/bash

#install dependencies
sudo apt update -y && sudo apt -y install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit

#join domain and start service
sudo systemctl enable --now sssd
sudo realm discover -v cnlab.local
echo 'password' | sudo realm join -v -U administrator cnlab.local
#manual ip specification in case dns resolution fails (it usually does, who knows)
echo 'password' | sudo realm join -v -U administrator 10.8.10.100

#edit pam config
cat <<EOF | sudo tee -a /etc/pam.d/common-session
session required pam_unix.so
session optional pam_sss.so
session optional pam_systemd.so
session required pam_mkhomedir.so
#session optional pam_exec.so /opt/user.sh
EOF

#create admin group and add it to sudoers
sudo groupadd admins
echo '%admins ALL=(ALL:ALL) ALL' | sudo tee -a /etc/sudoers

#cron job for joining admins group and mounting network drive
sudo chmod 755 /opt/user.sh
echo '@reboot /opt/user.sh' | sudo tee -a /var/spool/cron/crontabs/root
