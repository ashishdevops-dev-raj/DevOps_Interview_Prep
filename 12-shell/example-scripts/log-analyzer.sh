#!/bin/bash
# Log Analyzer Script
# Analyzes log files and generates reports

set -euo pipefail

# Configuration
LOG_FILE="${1:-/var/log/syslog}"
OUTPUT_DIR="./log-reports"
DATE=$(date +%Y%m%d_%H%M%S)

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Logging
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file not found: $LOG_FILE" >&2
    exit 1
fi

log "${GREEN}Analyzing log file: $LOG_FILE${NC}"

# Generate report filename
REPORT_FILE="${OUTPUT_DIR}/log-report-${DATE}.txt"

{
    echo "=== Log Analysis Report ==="
    echo "Log File: $LOG_FILE"
    echo "Generated: $(date)"
    echo ""
    
    # Total lines
    echo "=== Summary ==="
    total_lines=$(wc -l < "$LOG_FILE")
    echo "Total lines: $total_lines"
    echo ""
    
    # Error count
    echo "=== Errors ==="
    error_count=$(grep -i "error\|fail\|critical" "$LOG_FILE" | wc -l)
    echo "Error count: $error_count"
    echo ""
    
    # Top error messages
    echo "=== Top 10 Error Messages ==="
    grep -i "error\|fail\|critical" "$LOG_FILE" | \
        sed 's/.*\(error\|fail\|critical\).*/\1/i' | \
        sort | uniq -c | sort -rn | head -10
    echo ""
    
    # Warning count
    echo "=== Warnings ==="
    warning_count=$(grep -i "warn" "$LOG_FILE" | wc -l)
    echo "Warning count: $warning_count"
    echo ""
    
    # Most active hours
    echo "=== Most Active Hours ==="
    grep -oP '\d{2}:\d{2}:\d{2}' "$LOG_FILE" | \
        cut -d: -f1 | \
        sort | uniq -c | sort -rn | head -10
    echo ""
    
    # IP addresses (if any)
    echo "=== IP Addresses ==="
    grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$LOG_FILE" | \
        sort | uniq -c | sort -rn | head -10
    echo ""
    
    # Recent errors (last 50)
    echo "=== Recent Errors (Last 50) ==="
    grep -i "error\|fail\|critical" "$LOG_FILE" | tail -50
    
} | tee "$REPORT_FILE"

log "${GREEN}Report saved to: $REPORT_FILE${NC}"

