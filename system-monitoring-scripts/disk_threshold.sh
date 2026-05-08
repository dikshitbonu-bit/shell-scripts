#!/bin/bash


THRESHOLD=80

df -h --output=target,pcent | tail -n +2 | while read -r mount usage; do
  usage_number="${usage%\%}"
  if [ "$usage_number" -gt "$THRESHOLD" ]; then
	  echo "WARNING: DISK THRESHOLD EXCEEDED"
	  echo "filesystem: $mount | usage: $usage_number exceeded threshold $THRESHOLD"
  else
	  echo "[OK] $mount | usage: $usage_number"
  fi

done

echo "Disk scan completed successfully"
