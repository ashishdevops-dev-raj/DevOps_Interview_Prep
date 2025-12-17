#!/bin/bash
# Advanced Level Script 26: Security Audit
# Comprehensive security audit script

set -euo pipefail

REPORT_FILE="./security-audit-$(date +%Y%m%d_%H%M%S).txt"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$REPORT_FILE"
}

check_permissions() {
    log "=== Checking File Permissions ==="
    
    # World-writable files
    log "World-writable files:"
    find / -type f -perm -002 2>/dev/null | head -20 | tee -a "$REPORT_FILE"
    
    # SUID/SGID files
    log ""
    log "SUID/SGID files:"
    find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null | head -20 | tee -a "$REPORT_FILE"
}

check_users() {
    log ""
    log "=== User Account Audit ==="
    
    # Users with no password
    log "Users with no password:"
    awk -F: '($2 == "" ) {print $1}' /etc/shadow 2>/dev/null | tee -a "$REPORT_FILE"
    
    # Users with UID 0 (other than root)
    log ""
    log "Users with UID 0:"
    awk -F: '($3 == 0) {print $1}' /etc/passwd | tee -a "$REPORT_FILE"
}

check_services() {
    log ""
    log "=== Running Services ==="
    systemctl list-units --type=service --state=running | grep -E "^  " | awk '{print $1}' | tee -a "$REPORT_FILE"
}

check_network() {
    log ""
    log "=== Network Connections ==="
    log "Listening ports:"
    ss -tulpn | grep LISTEN | tee -a "$REPORT_FILE"
}

check_logs() {
    log ""
    log "=== Recent Failed Login Attempts ==="
    grep -i "failed\|invalid\|authentication failure" /var/log/auth.log 2>/dev/null | tail -20 | tee -a "$REPORT_FILE" || \
    grep -i "failed\|invalid\|authentication failure" /var/log/secure 2>/dev/null | tail -20 | tee -a "$REPORT_FILE" || \
    log "No auth logs found"
}

main() {
    log "=== Security Audit Report ==="
    log "Generated: $(date)"
    log "Hostname: $(hostname)"
    log ""
    
    check_permissions
    check_users
    check_services
    check_network
    check_logs
    
    log ""
    log "=== Audit Complete ==="
    log "Report saved to: $REPORT_FILE"
}

main "$@"

