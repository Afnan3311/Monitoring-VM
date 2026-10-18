#!/bin/bash
#author:afnan
#date:16/10/2026
#version:1.0
#task:Monitoring EC2
sudo systemctl list-units --type=service --state=running 
top -b -n 1
free -h
df -h

