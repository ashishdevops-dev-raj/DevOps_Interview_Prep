#!/bin/bash
# Medium Level Script 14: Detailed Disk Usage
# Show detailed disk usage information

echo "=== Disk Usage Summary ==="
df -h | awk 'NR==1 || $5+0 > 50 {print}'

echo ""
echo "=== Top 10 Largest Directories ==="
du -h --max-depth=1 2>/dev/null | sort -rh | head -10

echo ""
echo "=== Files Larger than 100MB ==="
find . -type f -size +100M -exec ls -lh {} \; 2>/dev/null | awk '{print $5, $9}' | head -10

