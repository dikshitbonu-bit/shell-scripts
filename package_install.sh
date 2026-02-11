#!/bin/bash
#
#
#
#
if [ "$EUID" -ne 0 ]; then echo "Run as root"; exit 1; fi
service=("nginx" "curl" "docker.io")
for package in "${service[@]}" ; do
	if dpkg -s "$package" &>/dev/null; then
		echo "$package is already installed"
	else
		echo "$package is being installed..."
		sudo apt-get install $package -y > /dev/null 
		echo "$package is successfully installed"
	fi
	sudo systemctl status $package &>/dev/null
                if systemctl is-active --quiet $package; then
                        echo " $package is active"
                else
                        echo " $package is inactive"
		fi
done
