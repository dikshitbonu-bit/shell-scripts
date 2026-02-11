#!/bin/bash
#
#
set -euo pipefail
fun1(){
	echo "===== Host name and OS details ====="
	hostname
	cat /etc/os-release | awk 'NR==1 {print $1,$2,$3}'
}

fun2(){
	echo "===== UPTIME  ====="
	uptime -p
}

fun3() {
    echo "===== Top 5 Disk Usage ====="
     du -xhd1 / 2>/dev/null  | sort -hr | head -5
    
}

fun4(){
	 echo "===== Memory usage ======"
	 free -h | awk 'NR<=2 {print $1,$2,$3,$4,$5,$6,$7} '
}

fun5(){
    echo "===== Top 5 CPU Consuming Processes ====="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
}

main_func(){
	fun1
	fun2
	fun3
	fun4
	fun5

}

main_func



