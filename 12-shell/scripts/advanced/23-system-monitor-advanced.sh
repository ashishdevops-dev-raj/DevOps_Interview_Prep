#!/bin/bash
# Advanced Level Script 23: Advanced System Monitor
# Comprehensive system monitoring with alerts and logging

set -euo pipefail

LOG_FILE="/var/log/system-monitor.log"
ALERT_EMAIL="${ALERT_EMAIL:-}"
THRESHOLD_CPU=80
THRESHOLD_MEMORY=80
THRESHOLD_DISK=80
THRESHOLD_LOAD=2.0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    local cpu_int=${cpu_usage%.*}
    
    if (( $(echo "$cpu_usage > $THRESHOLD_CPU" | bc -l) )); then
        log "${RED}ALERT: CPU usage is ${cpu_int}% (threshold: ${THRESHOLD_CPU}%)${NC}"
        return 1
    fi
    log "${GREEN}CPU: ${cpu_int}%${NC}"
    return 0
}

check_memory() {
    local mem_info=$(free | grep Mem)
    local total=$(echo $mem_info | awk '{print $2}')
    local used=$(echo $mem_info | awk '{print $3}')
    local percent=$((used * 100 / total))
    
    if [ $percent -gt $THRESHOLD_MEMORY ]; then
        log "${RED}ALERT: Memory usage is ${percent}% (threshold: ${THRESHOLD_MEMORY}%)${NC}"
        return 1
    fi
    log "${GREEN}Memory: ${percent}%${NC}"
    return 0
}

check_disk() {
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ $disk_usage -gt $THRESHOLD_DISK ]; then
        log "${RED}ALERT: Disk usage is ${disk_usage}% (threshold: ${THRESHOLD_DISK}%)${NC}"
        return 1
    fi
    log "${GREEN}Disk: ${disk_usage}%${NC}"
    return 0
}

check_load() {
    local load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    
    if (( $(echo "$load > $THRESHOLD_LOAD" | bc -l) )); then
        log "${RED}ALERT: Load average is ${load} (threshold: ${THRESHOLD_LOAD})${NC}"
        return 1
    fi
    log "${GREEN}Load: ${load}${NC}"
    return 0
}

main() {
    log "=== System Monitor Report ==="
    
    local alerts=0
    check_cpu || ((alerts++))
    check_memory || ((alerts++))
    check_disk || ((alerts++))
    check_load || ((alerts++))
    
    # Top processes
    log ""
    log "Top 5 CPU processes:"
    ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "  %s (%.1f%%)\n", $11, $3}'
    
    log ""
    log "Top 5 Memory processes:"
    ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "  %s (%.1f%%)\n", $11, $4}'
    
    if [ $alerts -gt 0 ]; then
        log ""
        log "${RED}Total alerts: $alerts${NC}"
        exit 1
    fi
    
    exit 0
}

main "$@"

