#!/bin/bash

# Disk Usage Monitoring Script
# This script checks disk usage and alerts if usage exceeds threshold

THRESHOLD=80  # Percentage threshold
EMAIL="admin@example.com"  # Email for alerts

# Get disk usage percentage (excluding filesystem column)
DISK_USAGE=$(df -h | awk 'NR>1 {print $5}' | sed 's/%//')

# Get filesystem names
FILESYSTEMS=$(df -h | awk 'NR>1 {print $1}')

# Check each filesystem
echo "=== Disk Usage Report ==="
echo "Date: $(date)"
echo ""

df -h | awk 'NR==1 || NR>1 {printf "%-20s %10s %10s %10s %6s %s\n", $1, $2, $3, $4, $5, $6}'

echo ""
echo "=== Filesystems Exceeding ${THRESHOLD}% ==="

ALERT_FLAG=0
while IFS= read -r fs; do
    USAGE=$(df -h "$fs" | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "WARNING: $fs is ${USAGE}% full"
        ALERT_FLAG=1
    fi
done <<< "$FILESYSTEMS"

if [ $ALERT_FLAG -eq 0 ]; then
    echo "All filesystems are within threshold."
fi

# Optional: Send email alert if threshold exceeded
# if [ $ALERT_FLAG -eq 1 ]; then
#     echo "Sending alert email..."
#     # mail -s "Disk Usage Alert" $EMAIL < /tmp/disk_usage_report.txt
# fi

exit $ALERT_FLAG

