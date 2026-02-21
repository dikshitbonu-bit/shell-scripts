#!/bin/bash

set -euo pipefail
file="$1"

if [ -z "$1" ]; then
	echo "please provide the logfile"
	exit 1
fi

if [ ! -f "$1" ]; then
	echo "the given logfile doesn't exist"
	exit 1
fi

ec(){
	error_count=$( grep -ci "Error" "$file" || true)
	echo "TOTAL ERROR COUNT : $error_count"
}


critical(){
	  CRITICAL_EVENTS=$( grep -in "critical" "$file" | sed 's/^/line /; s/:/: /' || true)
	  if [[ -z "$CRITICAL_EVENTS" ]]; then
            echo "No critical events found"
          else
            echo "$CRITICAL_EVENTS"
          fi
}



top_5_errors(){

	echo "######## TOP 5 MOST COMMON ERROR MESSAGES ######"
       	top_5_errors=$(grep -i "error" "$file" | awk '{ $1=$2=$3=$4=$5=$6= ""; print  }' | sort | uniq -c | sort -rn | head -5 || true)
 	if [[ -z "$top_5_errors" ]]; then
            echo " No errors found at all"
        else
            echo "$top_5_errors"
        fi

}



summary_report(){
	REPORT="log_report_of_"$file"_$(date +%Y-%m-%d_%H-%M-%S).txt"
	TOTAL_LINES=$(wc -l < "$file")
	ARCHIVE_DIR="archive"
	{
		echo "===== Log Analysis Report ====="
		echo
		echo "Date of Analysis: $(date)"
		echo "Log file: $(basename "$file")"
		echo "Total Lines Processed: $TOTAL_LINES"
		ec
		critical
		top_5_errors
	}  >> "$REPORT"
	echo "LOG SUMMARY REPORT CREATED : $REPORT"
	mkdir -p "$ARCHIVE_DIR"

    	mv "$file" "$ARCHIVE_DIR/"

    	echo "Log file archived to $ARCHIVE_DIR/"

}
summary_report
