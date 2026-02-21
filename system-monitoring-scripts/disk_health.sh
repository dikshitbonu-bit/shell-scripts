#!/bin/bash

####################################################
# This is a disk threshold monitoring script
# Author: dikshith
# version: v1.0
# usage: ./disk_health.sh
##################################################

echo "##############################################"
echo "           Disk monitoring message"
echo "##############################################"

THRESHOLD=80

disk_usage=$(  df / | awk 'NR==2 {print $5}'| sed 's/%//')

timestamp=$(date '+%F %T')

if [ "$disk_usage" -ge "$THRESHOLD" ];then
        echo "WARNING: $timestamp disk usage is high: ${disk_usage}%"
        exit 1
else
        echo "$timestamp : Disk usage is healthy: ${disk_usage}%"
        exit 0
fi
