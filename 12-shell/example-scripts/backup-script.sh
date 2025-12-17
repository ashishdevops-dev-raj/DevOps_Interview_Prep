#!/bin/bash
# Backup Script
# Creates compressed backups of specified directories

set -euo pipefail

# Configuration
BACKUP_DIR="/backup"
SOURCE_DIRS=(
    "/home"
    "/etc"
    "/var/www"
)
RETENTION_DAYS=7
COMPRESSION="gzip"  # gzip or bzip2

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Logging
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Error handling
error_exit() {
    log "${RED}ERROR: $1${NC}" >&2
    exit 1
}

# Create backup directory
create_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR" || error_exit "Failed to create backup directory"
        log "${GREEN}Created backup directory: $BACKUP_DIR${NC}"
    fi
}

# Get backup filename
get_backup_filename() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local extension="tar.gz"
    
    if [ "$COMPRESSION" = "bzip2" ]; then
        extension="tar.bz2"
    fi
    
    echo "${BACKUP_DIR}/backup_${timestamp}.${extension}"
}

# Create backup
create_backup() {
    local backup_file=$(get_backup_filename)
    local compression_flag="z"
    
    if [ "$COMPRESSION" = "bzip2" ]; then
        compression_flag="j"
    fi
    
    log "Creating backup: $backup_file"
    
    # Check if source directories exist
    local missing_dirs=()
    for dir in "${SOURCE_DIRS[@]}"; do
        if [ ! -d "$dir" ]; then
            missing_dirs+=("$dir")
        fi
    done
    
    if [ ${#missing_dirs[@]} -gt 0 ]; then
        log "${YELLOW}Warning: Missing directories: ${missing_dirs[*]}${NC}"
    fi
    
    # Create backup
    if tar -c${compression_flag}f "$backup_file" "${SOURCE_DIRS[@]}" 2>/dev/null; then
        local size=$(du -h "$backup_file" | cut -f1)
        log "${GREEN}Backup created successfully! Size: $size${NC}"
        
        # Create checksum
        local checksum_file="${backup_file}.md5"
        md5sum "$backup_file" > "$checksum_file"
        log "Checksum saved: $checksum_file"
        
        echo "$backup_file"
    else
        error_exit "Failed to create backup"
    fi
}

# Cleanup old backups
cleanup_old_backups() {
    log "Cleaning up backups older than $RETENTION_DAYS days..."
    
    local deleted=0
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            rm -f "$file"
            rm -f "${file}.md5"
            ((deleted++))
        fi
    done < <(find "$BACKUP_DIR" -name "backup_*.tar.*" -type f -mtime +$RETENTION_DAYS)
    
    if [ $deleted -gt 0 ]; then
        log "${GREEN}Deleted $deleted old backup(s)${NC}"
    else
        log "No old backups to delete"
    fi
}

# List current backups
list_backups() {
    log "Current backups:"
    if [ -d "$BACKUP_DIR" ]; then
        local count=0
        while IFS= read -r file; do
            if [ -f "$file" ]; then
                local size=$(du -h "$file" | cut -f1)
                local date=$(stat -c %y "$file" | cut -d' ' -f1)
                log "  $(basename "$file") - $size - $date"
                ((count++))
            fi
        done < <(find "$BACKUP_DIR" -name "backup_*.tar.*" -type f | sort -r)
        
        if [ $count -eq 0 ]; then
            log "  No backups found"
        fi
    else
        log "  Backup directory does not exist"
    fi
}

# Verify backup
verify_backup() {
    local backup_file="$1"
    local checksum_file="${backup_file}.md5"
    
    if [ ! -f "$checksum_file" ]; then
        log "${YELLOW}Warning: No checksum file found${NC}"
        return 1
    fi
    
    log "Verifying backup integrity..."
    if md5sum -c "$checksum_file" > /dev/null 2>&1; then
        log "${GREEN}Backup verification successful${NC}"
        return 0
    else
        log "${RED}Backup verification failed!${NC}"
        return 1
    fi
}

# Main function
main() {
    log "=== Backup Script ==="
    log "Starting backup process..."
    log ""
    
    # Create backup directory
    create_backup_dir
    
    # Create backup
    local backup_file=$(create_backup)
    
    # Verify backup
    verify_backup "$backup_file"
    
    # Cleanup old backups
    cleanup_old_backups
    
    log ""
    list_backups
    
    log ""
    log "${GREEN}=== Backup Process Completed ===${NC}"
}

# Run main function
main "$@"

