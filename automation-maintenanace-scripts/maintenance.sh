#!/bin/bash
set -euo pipefail

################################
# CONFIG
################################

LOG_DIR="/var/log/myapp"
BACKUP_SRC="/home/ubuntu/data"
BACKUP_DEST="/home/ubuntu/backups"
LOGFILE="/var/log/maintenance.log"

################################
# LOG FUNCTION
################################

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOGFILE"
}

################################
# LOG ROTATION
################################

rotate_logs() {
  log "Starting log rotation"

  if [[ ! -d "$LOG_DIR" ]]; then
    log "ERROR: Log directory not found"
    exit 1
  fi

  compressed=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; -print | wc -l)

  deleted=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -delete -print | wc -l)

  log "Compressed $compressed log files"
  log "Deleted $deleted old archives"
}

################################
# BACKUP
################################

backup_server() {
  log "Starting backup"

  if [[ ! -d "$BACKUP_SRC" ]]; then
    log "ERROR: Source directory not found"
    exit 1
  fi

  mkdir -p "$BACKUP_DEST"

  DATE=$(date +%Y-%m-%d)
  ARCHIVE="$BACKUP_DEST/backup-$DATE.tar.gz"

  tar -czf "$ARCHIVE" "$BACKUP_SRC"

  if [[ ! -f "$ARCHIVE" ]]; then
    log "ERROR: Backup failed"
    exit 1
  fi

  SIZE=$(du -h "$ARCHIVE" | cut -f1)

  log "Backup created: $(basename "$ARCHIVE") Size: $SIZE"

  old=$(find "$BACKUP_DEST" -name "backup-*.tar.gz" -mtime +14 -delete -print | wc -l)

  log "Deleted $old old backups"
}

################################
# MAIN
################################

main() {
  log "Maintenance started"

  rotate_logs
  backup_server

  log "Maintenance completed"
}

main

