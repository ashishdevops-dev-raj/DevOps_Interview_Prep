#!/bin/bash
# Medium Level Script 12: Process Monitor
# Monitor and display process information

read -p "Enter process name (or 'all' for all processes): " proc_name

if [ "$proc_name" = "all" ]; then
    echo "=== All Processes ==="
    ps aux | head -20
else
    echo "=== Processes matching '$proc_name' ==="
    if pgrep "$proc_name" > /dev/null; then
        ps aux | grep "$proc_name" | grep -v grep
        echo ""
        echo "Process count: $(pgrep -c "$proc_name")"
    else
        echo "No processes found matching: $proc_name"
    fi
fi

