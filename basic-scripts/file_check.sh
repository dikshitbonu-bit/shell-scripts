#!/bin/bash
#
#
read -p "Enter the file you want to check; " FILE

if [ -f "$FILE" ]; then
	echo "FILE EXISTS"

else
   echo "FILE DOES NOT EXIST"

fi   
