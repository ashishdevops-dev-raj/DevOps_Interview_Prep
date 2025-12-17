#!/bin/bash
# System Monitoring Script
# Monitors system resources and logs information

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
THRESHOLD_CPU=80
THRESHOLD_MEMORY=80
THRESHOLD_DISK=80
LOG_FILE="/var/log/system-monitor.log"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Check CPU usage
check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    local cpu_int=${cpu_usage%.*}
    
    if [ "$cpu_int" -gt "$THRESHOLD_CPU" ]; then
        log "${RED}WARNING: CPU usage is ${cpu_int}% (threshold: ${THRESHOLD_CPU}%)${NC}"
        return 1
    else
        log "${GREEN}CPU usage: ${cpu_int}%${NC}"
        return 0
    fi
}

# Check memory usage
check_memory() {
    local mem_info=$(free | grep Mem)
    local total_mem=$(echo $mem_info | awk '{print $2}')
    local used_mem=$(echo $mem_info | awk '{print $3}')
    local mem_percent=$((used_mem * 100 / total_mem))
    
    if [ "$mem_percent" -gt "$THRESHOLD_MEMORY" ]; then
        log "${RED}WARNING: Memory usage is ${mem_percent}% (threshold: ${THRESHOLD_MEMORY}%)${NC}"
        return 1
    else
        log "${GREEN}Memory usage: ${mem_percent}%${NC}"
        return 0
    fi
}

# Check disk usage
check_disk() {
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ "$disk_usage" -gt "$THRESHOLD_DISK" ]; then
        log "${RED}WARNING: Disk usage is ${disk_usage}% (threshold: ${THRESHOLD_DISK}%)${NC}"
        return 1
    else
        log "${GREEN}Disk usage: ${disk_usage}%${NC}"
        return 0
    fi
}

# Get top processes by CPU
get_top_processes() {
    log "Top 5 CPU consuming processes:"
    ps aux --sort=-%cpu | head -n 6 | tail -n 5 | while read line; do
        log "  $line"
    done
}

# Get top processes by memory
get_top_memory_processes() {
    log "Top 5 memory consuming processes:"
    ps aux --sort=-%mem | head -n 6 | tail -n 5 | while read line; do
        log "  $line"
    done
}

# Main function
main() {
    log "=== System Monitor Report ==="
    log "Date: $(date)"
    log ""
    
    local errors=0
    
    # Run checks
    check_cpu || ((errors++))
    check_memory || ((errors++))
    check_disk || ((errors++))
    
    log ""
    get_top_processes
    log ""
    get_top_memory_processes
    
    log ""
    if [ $errors -eq 0 ]; then
        log "${GREEN}All checks passed${NC}"
        exit 0
    else
        log "${RED}${errors} check(s) failed${NC}"
        exit 1
    fi
}

# Run main function
main "$@"

