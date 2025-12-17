#!/bin/bash

# CPU Monitoring Script
# Monitors CPU usage and processes

THRESHOLD=80  # CPU usage threshold percentage
DURATION=5    # Monitoring duration in seconds

echo "=== CPU Monitoring Report ==="
echo "Date: $(date)"
echo ""

# Overall CPU usage
echo "=== Overall CPU Usage ==="
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Idle: " 100 - $1"%"}'
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2}'

echo ""
echo "=== Top 10 CPU Consuming Processes ==="
ps aux --sort=-%cpu | head -n 11 | awk '{printf "%-8s %6s %6s %10s %s\n", $1, $2, $3"%", $4"%", $11}'

echo ""
echo "=== CPU Load Average ==="
uptime | awk -F'load average:' '{print "Load Average:" $2}'

echo ""
echo "=== CPU Information ==="
echo "CPU Cores: $(nproc)"
echo "CPU Model: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"

# Check if CPU usage exceeds threshold
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_USAGE_INT=${CPU_USAGE%.*}

if [ "$CPU_USAGE_INT" -gt "$THRESHOLD" ]; then
    echo ""
    echo "WARNING: CPU usage (${CPU_USAGE_INT}%) exceeds threshold (${THRESHOLD}%)"
    exit 1
else
    echo ""
    echo "CPU usage is within normal range."
    exit 0
fi

