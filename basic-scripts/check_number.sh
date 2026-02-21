#!/bin/bash
#
#

read -p "Enter the number you want to check: " NUMBER

if [ "$NUMBER" -gt 0 ]; then
	echo "number is positive"

elif [ "$NUMBER" -lt 0 ]; then
      echo "number is negative"

else 
  echo "number is zero"

fi  
