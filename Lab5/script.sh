#!/bin/bash

sudo apt-get update
sudo apt-get install apache2


sudo apt-get install mysql-server
sudo apt-get install php libapache2-mod-php php-mysql
sudo systemctl restart apache2
sudo systemctl start mysql
echo "Installation Hogayi Bhai"


