#!/bin/bash
#
#
#
read -p "Enter the service name you want to check: " SERVICE 

read -p "Do you want to check the status? (y/n): " INPUT 

if [ "$INPUT" = "y" ]; then
     sudo systemctl status $SERVICE > /dev/null 

     if systemctl is-active --quiet $SERVICE ; then
	     echo "$SERVICE is active"

     else 
	    echo "$SERVICE is inactive" 
     fi
else 
   echo "skipped"
fi   
