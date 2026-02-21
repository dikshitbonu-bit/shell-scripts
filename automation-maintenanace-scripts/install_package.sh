#!/bin/bash 
#
#
install_package(){
	echo "Installing $1"
	sudo apt-get update >/dev/null && sudo apt-get install $1 -y > /dev/null
	echo "installed $1"
}


install_package $1
