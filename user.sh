#!/bin/bash
 
username=$PAM_USER
 
#sudo echo $administrators_group $username >> /opt/test.log
 
if [[ -n "$username" && "$username" != "sddm" && "$username" != "lightdm" ]]; then
 
sudo echo admins $username >> /opt/test.log
sudo usermod -aG admins $username
 
else
        echo "Pam ignored" >> /opt/test.log
fi
exit 0
