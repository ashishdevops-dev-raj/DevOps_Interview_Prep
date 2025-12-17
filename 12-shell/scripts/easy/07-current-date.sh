#!/bin/bash
# Easy Level Script 7: Display Current Date and Time
# Show current date, time, and system information

echo "Current Date: $(date +%Y-%m-%d)"
echo "Current Time: $(date +%H:%M:%S)"
echo "Day of Week: $(date +%A)"
echo "Uptime: $(uptime -p)"

