#!/bin/bash
# Advanced Level Script 21: Advanced Backup System
# Comprehensive backup with compression, encryption, and rotation

set -euo pipefail

BACKUP_DIR="/backup"
SOURCE_DIRS=("${@:-$HOME}")
RETENTION_DAYS=7
COMPRESSION="gzip"
ENCRYPT=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --encrypt)
            ENCRYPT=true
            shift
            ;;
        --retention)
            RETENTION_DAYS="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

mkdir -p "$BACKUP_DIR"
timestamp=$(date +%Y%m%d_%H%M%S)
backup_file="$BACKUP_DIR/backup_${timestamp}.tar.gz"

echo "Creating backup: $backup_file"
tar -czf "$backup_file" "${SOURCE_DIRS[@]}" 2>/dev/null

if [ "$ENCRYPT" = true ]; then
    echo "Encrypting backup..."
    gpg --symmetric --cipher-algo AES256 "$backup_file" 2>/dev/null || {
        echo "Warning: GPG encryption failed, backup not encrypted"
    }
    rm -f "$backup_file"
    backup_file="${backup_file}.gpg"
fi

# Create checksum
md5sum "$backup_file" > "${backup_file}.md5"

# Cleanup old backups
find "$BACKUP_DIR" -name "backup_*.tar.gz*" -type f -mtime +$RETENTION_DAYS -delete

echo "Backup completed: $backup_file"
echo "Size: $(du -h "$backup_file" | cut -f1)"

