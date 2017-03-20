#!/bin/bash
sudo apt-get update
sudo apt-get install -y sysbench 
sudo apt-get install -y mysql-server
mysql -u root -ppassword -e "CREATE USER 'sysbench'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'sysbench'@'localhost' IDENTIFIED  BY 'password';"