#!/bin/bash
# Medium Level Script 18: Service Status Check
# Check status of system services

read -p "Enter service name (or 'all' for all services): " service_name

if [ "$service_name" = "all" ]; then
    echo "=== All Services ==="
    systemctl list-units --type=service --state=running | head -20
else
    if systemctl list-unit-files | grep -q "$service_name"; then
        echo "=== Service Status: $service_name ==="
        systemctl status "$service_name" --no-pager -l | head -15
    else
        echo "Service not found: $service_name"
        echo "Available services containing '$service_name':"
        systemctl list-unit-files | grep "$service_name" | head -5
    fi
fi

