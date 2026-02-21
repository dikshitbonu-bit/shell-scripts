#!/bin/bash

####### This shell script is used for log rotation ############

set -euo pipefail

log_dir="$1"


# exit if the input directory doesn't exit
if [ ! -d "$log_dir" ]; then
	echo "Directory "$log_dir" doesn't exist"
	exit 1
fi
# find number of logs compressed
compressed=$(find "$log_dir" -name "*.log*" -mtime +7 | wc -l)

# find number of files deleted
deleted=$(find "$log_dir" -name "*.gz*" -mtime +30 | wc -l)

#compress the log files

find "$log_dir" -name "*.log*" -mtime +7 - exec gzip {} \;

# delete ancient logs

find "$log_dir" -name "*.gz*" -mtime +30 - delete

echo "compressed logs: $compressed"
echo "deleted logs: $deleted"
