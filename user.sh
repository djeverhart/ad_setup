#!/bin/bash

username=$PAM_USER
sudo rm -f /etc/resolv.conf
sudo sh -c 'echo "nameserver 10.8.10.100" > /etc/resolv.conf'

#sudo echo $administrators_group $username >> /opt/test.log

if [[ -n "$username" && "$username" != "sddm" && "$username" != "lightdm" && "$username" != "cnadmin" && "$username" != "root" ]]; then

sudo sh -c 'echo admins $username >> /opt/test.log'
sudo usermod -aG admins $username

sshpass -p "Snowsuit9-Breath0-Karaoke7-Frightful3" ssh fowner@10.8.10.199 "sudo mkdir -p /mnt/Primary/Users/$username"
sudo umount /mnt/Sync
sudo mount -t cifs //10.8.10.199/User/$username /mnt/Sync -o username=fowner,password=Snowsuit9-Breath0-Karaoke7-Frightful3 2>/tmp/mount_error.log

fi
