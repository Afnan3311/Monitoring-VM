#!/bin/bash
#author:afnan
#date:16/10/2026
#version:1.0
#task:Monitoring EC2

set -e 

echo "####################################"

echo "#############Services###############"

sudo systemctl list-units --type=service --state=running --no-pager

echo "#############CPU Usage##############"

top -b -n 1

echo "####################################"

echo "#############Memory Usage###########"

free -h

echo "####################################"

echo "#############Disk Usage#############"

df -h

echo "####################################"

echo "Monitoring Completed Succesfully"
echo "Date:" &(date)


