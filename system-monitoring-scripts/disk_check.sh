#!/bin/bash



check_disk(){
	echo "Disk usage of root: $(df -h | awk 'NR==2 {print $5}')"

}

check_memory(){
	echo "Total memory available: $(free -h | awk 'NR==2 {print $7}')"

}

system_check(){
	check_disk
	check_memory
}

system_check  
