#!/bin/bash
# Advanced Level Script 27: Configuration Manager
# Manage application configurations with versioning

set -euo pipefail

CONFIG_DIR="./configs"
BACKUP_DIR="./config-backups"

mkdir -p "$CONFIG_DIR" "$BACKUP_DIR"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

backup_config() {
    local config_file="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/$(basename $config_file).${timestamp}"
    
    if [ -f "$config_file" ]; then
        cp "$config_file" "$backup_file"
        log "Backed up: $config_file -> $backup_file"
        echo "$backup_file"
    fi
}

deploy_config() {
    local source="$1"
    local target="$2"
    
    if [ ! -f "$source" ]; then
        log "Error: Source config not found: $source"
        return 1
    fi
    
    # Backup existing config
    if [ -f "$target" ]; then
        backup_config "$target"
    fi
    
    # Deploy new config
    cp "$source" "$target"
    log "Deployed: $source -> $target"
    
    # Validate config (example: JSON validation)
    if command -v jq &> /dev/null && [[ "$target" == *.json ]]; then
        if jq empty "$target" 2>/dev/null; then
            log "Config validation: PASSED"
        else
            log "Config validation: FAILED"
            return 1
        fi
    fi
    
    return 0
}

list_configs() {
    log "=== Available Configurations ==="
    if [ -d "$CONFIG_DIR" ]; then
        ls -lh "$CONFIG_DIR" | tail -n +2 | awk '{printf "  %s (%s)\n", $9, $5}'
    else
        log "No configurations found"
    fi
}

list_backups() {
    log "=== Configuration Backups ==="
    if [ -d "$BACKUP_DIR" ]; then
        ls -lht "$BACKUP_DIR" | tail -n +2 | head -10 | awk '{printf "  %s (%s)\n", $9, $6" "$7" "$8}'
    else
        log "No backups found"
    fi
}

restore_config() {
    local backup_file="$1"
    local target="$2"
    
    if [ ! -f "$backup_file" ]; then
        log "Error: Backup not found: $backup_file"
        return 1
    fi
    
    # Backup current config
    if [ -f "$target" ]; then
        backup_config "$target"
    fi
    
    cp "$backup_file" "$target"
    log "Restored: $backup_file -> $target"
}

main() {
    case "${1:-list}" in
        deploy)
            deploy_config "$2" "$3"
            ;;
        restore)
            restore_config "$2" "$3"
            ;;
        list)
            list_configs
            ;;
        backups)
            list_backups
            ;;
        *)
            echo "Usage: $0 {deploy|restore|list|backups} [args...]"
            exit 1
            ;;
    esac
}

main "$@"

