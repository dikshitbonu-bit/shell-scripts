#!/bin/bash
#
#

if [[ "$#" -eq 0 ]]; then
        echo "please enter the name or first arg"
        echo "Usage : ./greet.sh <name>"
	
else 
	echo "hello $1"
fi
