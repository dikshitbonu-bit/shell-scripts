#!/bin/bash
#
#
check_file() {
    [ -f /ec/passwd ]
}

check_file

if [ $? -eq 0 ]; then
    echo "File exists"
else
    echo "File missing"
fi

