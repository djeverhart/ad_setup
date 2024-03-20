#!/usr/bin/bash

sudo rm -f /etc/resolv.conf
sudo sh -c 'echo "nameserver 10.8.10.100" > /etc/resolv.conf'
#sudo sh -c 'echo "10.8.10.100       cnlab.local" >> /etc/hosts'
#sudo systemctl restart systemd-resolved

#switch to kde
sudo systemctl disable lightdm
sudo systemctl disable gdm
echo 'sddm shared/default-x-display-manager select sddm'
sudo debconf-set-selections
sudo apt install kde-plasma-desktop -y
sudo systemctl enable sddm
sudo apt remove -y dragon k3b kaddressbook kaddressbook-libs kdeaccessibility* kdepim-addons kdepim-runtime kdepim-runtime-libs kdiagram kf5-akonadi-calendar kf5-akonadi-mime kf5-akonadi-notes kf5-akonadi-search kf5-calendarsupport kf5-eventviews kf5-incidenceeditor kf5-kcalendarcore kf5-kcalendarutils kf5-kdav kf5-kidentitymanagement kf5-kimap kf5-kitinerary kf5-kldap kf5-kmailtransport kf5-kmailtransport-akonadi kf5-kmbox kf5-kontactinterface kf5-kpimtextedit kf5-kpkpass kf5-kross-core kf5-ksmtp kf5-ktnef kf5-libgravatar kf5-libkdepim kf5-libkleo kf5-libksane kf5-libksieve kf5-mailcommon kf5-mailimporter kf5-mailimporter-akonadi kf5-messagelib kf5-pimcommon kf5-pimcommon-akonadi kio-gdrive kipi-plugins kmahjongg kmail kmail-account-wizard kmail-libs kmines kolourpaint kolourpaint-libs kontact kontact-libs konversation korganizer korganizer-libs kpat krdc krdc-libs krfb krfb-libs krusader ktorrent kwrite libkdegames libkgapi libkmahjongg libkmahjongg-data libkolabxml libphonenumber libwinpr mpage pim-data-exporter pim-data-exporter-libs pim-sieve-editor plasma-welcome qgpgme qt5-qtwebengine-freeworld qtkeychain-qt5 scim* system-config-printer system-config-services system-config-users unoconv xsane xsane-gimp abrt-desktop
sudo apt install -y ark fedora-workstation-repositories ffmpegthumbs kate kde-l10n kde-runtime kf5-kimageformats okular sddm-kcm supergfxctl-plasmoid mpv plasma-lookandfeel libreoffice 

#install dependencies
sudo apt update -y && sudo apt -y install git nfs-common sshpass samba dolphin cifs-utils bzip2 xz-utils curl realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
sudo mkdir /mnt/Sync

#join domain and start service
echo 'DJ&TheQu1ps' | sudo realm join -v -U Administrator cnlab.local
#manual ip specification in case dns resolution fails (it usually does, who knows)
echo 'DJ&TheQu1ps' | sudo realm join -v -U Administrator 10.8.10.100
sudo systemctl enable sssd
sudo systemctl start sssd

#edit pam config
cat <<EOF | sudo tee -a /etc/pam.d/common-session
session optional pam_sss.so
session required pam_mkhomedir.so
session optional pam_exec.so /opt/user.sh.x
EOF

#create admin group and add it to sudoers
sudo groupadd admins
echo '%admins ALL=(ALL:ALL) ALL' | sudo tee -a /etc/sudoers
echo '%admins ALL=(ALL) NOPASSWD: /bin/mount, /bin/umount' | sudo tee -a /etc/sudoers

#add truenas server to known hosts to avoid the ecdsa warning
sudo ssh-keyscan -H 10.8.10.199 >> ~/.ssh/known_hosts

sudo rm -f /opt/run.sh
sudo rm "$0"
