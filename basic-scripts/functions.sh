#!/bin/bash
#
#

greet(){
	echo " hello $1 "

}

add(){
	read -p "Enter the first number: " NUM1
	read -p "Enter the Second number: " NUM2
	sum=$((NUM1 + NUM2))
	echo "sum of the two numbers is : $sum"
}

greet $1

add $sum


