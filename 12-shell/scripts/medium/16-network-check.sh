#!/bin/bash
# Medium Level Script 16: Network Connectivity Check
# Check network connectivity and configuration

echo "=== Network Interfaces ==="
ip -4 addr show | grep -E "^[0-9]+:|inet " | grep -v "127.0.0.1"

echo ""
echo "=== Default Gateway ==="
ip route | grep default

echo ""
echo "=== DNS Servers ==="
grep nameserver /etc/resolv.conf 2>/dev/null || echo "DNS config not found"

echo ""
read -p "Enter hostname to ping (or press Enter to skip): " hostname
if [ -n "$hostname" ]; then
    echo "Pinging $hostname..."
    ping -c 4 "$hostname" 2>/dev/null || echo "Ping failed"
fi

