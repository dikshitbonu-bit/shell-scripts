#!/bin/bash
#
read -p "Enter the number please : " NUM
while [ "$NUM" -ge 0 ]; do
	echo "$NUM"
	((NUM -- ))
done	
echo "Done"
