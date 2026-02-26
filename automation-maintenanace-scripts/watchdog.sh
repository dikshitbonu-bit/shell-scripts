#!/bin/bash

##############################################################
# This is a script for checking service status
# Author: Dikshith
# version:v.1
##############################################################

set -euo pipefail

# ---------------- Root Check ----------------
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root." >&2
    exit 1
fi

# ---------------- Argument Validation ----------------
if [ $# -ne 1 ]; then
    echo "Usage: ./watchdog.sh <service-name>" >&2
    exit 1
fi

service="$1"

# ---------------- Log File Handling ----------------
PRIMARY_LOG="/var/log/service_watchdog.log"
FALLBACK_LOG="./service_watchdog.log"

if touch "$PRIMARY_LOG" 2>/dev/null; then
    log_file="$PRIMARY_LOG"
else
    log_file="$FALLBACK_LOG"
fi

# ---------------- Logging Function ----------------
log() {
    local message="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$timestamp | $service | $message" >> "$log_file"
}

# ---------------- Service Existence Validation ----------------
if ! systemctl list-unit-files --type=service | grep -q "^${service}.service"; then
    echo "ERROR: Service '$service' does not exist." >&2
    log "Invalid service name." >&2
    exit 2
fi

# ---------------- Check If Running ----------------
if systemctl is-active --quiet "$service"; then
    log "Service is active."
    echo "Service is active."
    exit 0
else
    log "Service is inactive. Attempting restart."
    echo "Service is inactive. Attempting restart."

    # Restart attempt
    if systemctl restart "$service" > /dev/null 2>&1; then
        if systemctl is-active --quiet "$service"; then
            log "Service restarted successfully."
	    echo "Service restarted successfully."
            exit 0
        else
            log "Restart attempted but service still inactive."
	    echo "Restart attempted but service still inactive."
            exit 3
        fi
    else
        log "Service restart command failed."
	echo "Service restart command failed."
        exit 3
    fi
fi
