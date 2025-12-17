#!/bin/bash
# Easy Level Script 4: Check File Exists
# Check if a file exists

read -p "Enter file path: " filepath

if [ -f "$filepath" ]; then
    echo "File exists: $filepath"
    echo "File size: $(du -h "$filepath" | cut -f1)"
else
    echo "File does not exist: $filepath"
fi

