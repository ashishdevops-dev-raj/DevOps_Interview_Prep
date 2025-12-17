#!/bin/bash
# Advanced Level Script 25: Database Backup
# Automated database backup with rotation and compression

set -euo pipefail

DB_TYPE="${1:-mysql}"
DB_NAME="${2:-}"
DB_USER="${3:-root}"
BACKUP_DIR="/backup/databases"
RETENTION_DAYS=30
COMPRESSION="gzip"

mkdir -p "$BACKUP_DIR"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

backup_mysql() {
    local db_name="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/${db_name}_${timestamp}.sql"
    
    log "Backing up MySQL database: $db_name"
    
    if mysqldump -u "$DB_USER" -p"${DB_PASSWORD:-}" "$db_name" > "$backup_file" 2>/dev/null; then
        if [ "$COMPRESSION" = "gzip" ]; then
            gzip "$backup_file"
            backup_file="${backup_file}.gz"
        fi
        
        # Create checksum
        md5sum "$backup_file" > "${backup_file}.md5"
        
        log "Backup completed: $backup_file"
        log "Size: $(du -h "$backup_file" | cut -f1)"
        return 0
    else
        log "Error: Backup failed for $db_name"
        rm -f "$backup_file"
        return 1
    fi
}

backup_postgresql() {
    local db_name="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/${db_name}_${timestamp}.sql"
    
    log "Backing up PostgreSQL database: $db_name"
    
    if PGPASSWORD="${DB_PASSWORD:-}" pg_dump -U "$DB_USER" "$db_name" > "$backup_file" 2>/dev/null; then
        if [ "$COMPRESSION" = "gzip" ]; then
            gzip "$backup_file"
            backup_file="${backup_file}.gz"
        fi
        
        md5sum "$backup_file" > "${backup_file}.md5"
        
        log "Backup completed: $backup_file"
        return 0
    else
        log "Error: Backup failed for $db_name"
        rm -f "$backup_file"
        return 1
    fi
}

cleanup_old_backups() {
    log "Cleaning up backups older than $RETENTION_DAYS days..."
    find "$BACKUP_DIR" -name "*.sql*" -type f -mtime +$RETENTION_DAYS -delete
    find "$BACKUP_DIR" -name "*.md5" -type f -mtime +$RETENTION_DAYS -delete
}

main() {
    if [ -z "$DB_NAME" ]; then
        echo "Usage: $0 <mysql|postgresql> <database_name> [username]"
        exit 1
    fi
    
    case $DB_TYPE in
        mysql)
            backup_mysql "$DB_NAME"
            ;;
        postgresql|postgres)
            backup_postgresql "$DB_NAME"
            ;;
        *)
            log "Error: Unsupported database type: $DB_TYPE"
            exit 1
            ;;
    esac
    
    cleanup_old_backups
}

main "$@"

