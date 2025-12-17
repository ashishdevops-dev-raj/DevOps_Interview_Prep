#!/bin/bash
# Advanced Level Script 22: Advanced Log Analyzer
# Comprehensive log analysis with statistics and reporting

set -euo pipefail

LOG_FILE="${1:-/var/log/syslog}"
OUTPUT_DIR="./log-analysis-$(date +%Y%m%d_%H%M%S)"
THRESHOLD_ERROR=10
THRESHOLD_WARNING=50

mkdir -p "$OUTPUT_DIR"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file not found: $LOG_FILE"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"

# Generate comprehensive report
{
    echo "=== Log Analysis Report ==="
    echo "File: $LOG_FILE"
    echo "Generated: $(date)"
    echo ""
    
    # Basic statistics
    total_lines=$(wc -l < "$LOG_FILE")
    echo "Total Lines: $total_lines"
    
    # Error analysis
    error_count=$(grep -iE "error|fail|critical|fatal" "$LOG_FILE" | wc -l)
    echo "Errors: $error_count"
    
    # Warning analysis
    warning_count=$(grep -i "warn" "$LOG_FILE" | wc -l)
    echo "Warnings: $warning_count"
    
    # Top error messages
    echo ""
    echo "=== Top 10 Error Messages ==="
    grep -iE "error|fail|critical|fatal" "$LOG_FILE" | \
        sed 's/.*\(error\|fail\|critical\|fatal\): *\(.*\)/\2/i' | \
        sort | uniq -c | sort -rn | head -10
    
    # Hourly distribution
    echo ""
    echo "=== Hourly Distribution ==="
    grep -oP '\d{2}:\d{2}:\d{2}' "$LOG_FILE" | \
        cut -d: -f1 | \
        sort | uniq -c | \
        awk '{printf "Hour %02d:00 - %d events\n", $2, $1}'
    
    # IP addresses
    echo ""
    echo "=== IP Addresses (Top 10) ==="
    grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$LOG_FILE" | \
        sort | uniq -c | sort -rn | head -10
    
    # Recent critical events
    echo ""
    echo "=== Recent Critical Events (Last 20) ==="
    grep -iE "error|fail|critical|fatal" "$LOG_FILE" | tail -20
    
} | tee "$OUTPUT_DIR/analysis-report.txt"

echo "Report saved to: $OUTPUT_DIR/analysis-report.txt"

