#!/bin/bash

# Backup Script
# Creates compressed backup of specified directories

# Configuration
BACKUP_DIR="/backup"
SOURCE_DIRS=(
    "/home"
    "/etc"
    "/var/www"
)
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S)"
RETENTION_DAYS=7  # Keep backups for 7 days

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo -e "${GREEN}=== Starting Backup Process ===${NC}"
echo "Date: $(date)"
echo "Backup Name: $BACKUP_NAME"
echo ""

# Check if source directories exist
for dir in "${SOURCE_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo -e "${YELLOW}Warning: $dir does not exist, skipping...${NC}"
    fi
done

# Create backup
echo "Creating backup archive..."
tar -czf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" "${SOURCE_DIRS[@]}" 2>/dev/null

if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" | cut -f1)
    echo -e "${GREEN}Backup created successfully!${NC}"
    echo "Backup size: $BACKUP_SIZE"
    echo "Location: $BACKUP_DIR/${BACKUP_NAME}.tar.gz"
    
    # Create checksum
    md5sum "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" > "$BACKUP_DIR/${BACKUP_NAME}.md5"
    echo "Checksum file created: $BACKUP_DIR/${BACKUP_NAME}.md5"
else
    echo -e "${RED}Backup failed!${NC}"
    exit 1
fi

# Cleanup old backups
echo ""
echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -name "backup_*.md5" -type f -mtime +$RETENTION_DAYS -delete
echo "Cleanup completed."

# List current backups
echo ""
echo "=== Current Backups ==="
ls -lh "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | awk '{print $9, "(" $5 ")"}'

echo ""
echo -e "${GREEN}=== Backup Process Completed ===${NC}"

