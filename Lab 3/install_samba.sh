#!/bin/bash

read -p "Enter the username for Samba: " id_user1
read -p "Enter the password for Samba: " -s user1_password
echo ""

sudo apt update

sudo apt install samba -y

sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo touch /etc/samba/smb.conf

echo "[global]" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "workgroup = WORKGROUP" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "security = user" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "[shared]" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "comment = Shared Folder" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "path = /srv/samba/shared" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "browsable = yes" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "guest ok = no" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "read only = no" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "create mask = 0777" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "directory mask = 0777" | sudo tee -a /etc/samba/smb.conf > /dev/null
echo "valid users = $id_user1" | sudo tee -a /etc/samba/smb.conf > /dev/null


sudo useradd -m $id_user1
sudo smbpasswd -a $id_user1
echo -e "$user1_password\n$user1_password" | sudo smbpasswd -s $id_user1


sudo systemctl restart smbd

echo "Samba installation and configuration has been completed successfully"
