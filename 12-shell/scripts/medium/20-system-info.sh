#!/bin/bash
# Medium Level Script 20: System Information
# Display comprehensive system information

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "OS: $(uname -o)"
echo "Architecture: $(uname -m)"
echo "Uptime: $(uptime -p)"

echo ""
echo "=== CPU Information ==="
echo "CPU Cores: $(nproc)"
echo "CPU Model: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"

echo ""
echo "=== Memory Information ==="
free -h

echo ""
echo "=== Disk Information ==="
df -h | grep -E "^/dev/|Filesystem"

echo ""
echo "=== Load Average ==="
uptime | awk -F'load average:' '{print "Load Average:" $2}'

