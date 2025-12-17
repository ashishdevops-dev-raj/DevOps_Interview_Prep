#!/bin/bash
# Advanced Level Script 24: Automated Deployment
# Automated deployment script with rollback capability

set -euo pipefail

APP_NAME="${1:-myapp}"
VERSION="${2:-latest}"
DEPLOY_DIR="/opt/$APP_NAME"
BACKUP_DIR="/opt/backups/$APP_NAME"
MAX_BACKUPS=5

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

create_backup() {
    if [ -d "$DEPLOY_DIR" ]; then
        log "Creating backup..."
        mkdir -p "$BACKUP_DIR"
        backup_name="${APP_NAME}_$(date +%Y%m%d_%H%M%S).tar.gz"
        tar -czf "$BACKUP_DIR/$backup_name" -C "$(dirname $DEPLOY_DIR)" "$(basename $DEPLOY_DIR)"
        log "Backup created: $backup_name"
        echo "$backup_name"
    fi
}

deploy() {
    log "Deploying $APP_NAME version $VERSION..."
    
    # Create backup
    backup_file=$(create_backup)
    
    # Deployment steps
    log "Stopping application..."
    systemctl stop "$APP_NAME" 2>/dev/null || true
    
    log "Deploying files..."
    # Add your deployment logic here
    # cp -r /tmp/$APP_NAME-$VERSION/* "$DEPLOY_DIR/"
    
    log "Starting application..."
    systemctl start "$APP_NAME" 2>/dev/null || true
    
    # Health check
    sleep 5
    if systemctl is-active --quiet "$APP_NAME"; then
        log "Deployment successful!"
        cleanup_old_backups
        return 0
    else
        log "Deployment failed! Rolling back..."
        rollback "$backup_file"
        return 1
    fi
}

rollback() {
    local backup_file="$1"
    log "Rolling back to: $backup_file"
    
    systemctl stop "$APP_NAME" 2>/dev/null || true
    rm -rf "$DEPLOY_DIR"
    tar -xzf "$BACKUP_DIR/$backup_file" -C "$(dirname $DEPLOY_DIR)"
    systemctl start "$APP_NAME" 2>/dev/null || true
    
    log "Rollback completed"
}

cleanup_old_backups() {
    log "Cleaning up old backups (keeping last $MAX_BACKUPS)..."
    cd "$BACKUP_DIR"
    ls -t | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f 2>/dev/null || true
}

main() {
    if [ "$1" = "rollback" ]; then
        latest_backup=$(ls -t "$BACKUP_DIR" | head -1)
        rollback "$latest_backup"
    else
        deploy
    fi
}

main "$@"

