#!/bin/bash
# Medium Level Script 13: Log Search
# Search for patterns in log files

read -p "Enter log file path: " logfile
read -p "Enter search pattern: " pattern

if [ ! -f "$logfile" ]; then
    echo "Error: Log file not found: $logfile"
    exit 1
fi

echo "=== Searching for '$pattern' in $logfile ==="
matches=$(grep -i "$pattern" "$logfile" | wc -l)
echo "Total matches: $matches"
echo ""
echo "Sample matches (first 10):"
grep -i "$pattern" "$logfile" | head -10

