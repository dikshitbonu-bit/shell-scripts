#!/bin/bash
#
########################################################

#this is a script for checking the server's health
#Author: dikshith/devops team
#version:v1
#usage: ./system_health.sh

##########################################################
echo "======================================"
echo "        SYSTEM HEALTH CHECK"
echo "======================================"


echo "hostname: $(hostname)"
echo "current date & time: $( date '+%Y-%m-%d %H:%M:%S')"
echo "system uptime: $( uptime -p)"

echo "________________________________________________________________________________"

echo "disk usage:"

df -h

echo "________________________________________________________________________________"

echo "memory usage:"

free -h

echo "_________________________________________________________________________________"

echo "System health check completed successfully"



