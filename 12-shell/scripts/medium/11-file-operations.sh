#!/bin/bash
# Medium Level Script 11: File Operations
# Perform various file operations

set -euo pipefail

read -p "Enter file path: " filepath

if [ ! -f "$filepath" ]; then
    echo "Creating file: $filepath"
    touch "$filepath"
fi

echo "File: $filepath"
echo "Size: $(du -h "$filepath" | cut -f1)"
echo "Permissions: $(stat -c %a "$filepath")"
echo "Owner: $(stat -c %U "$filepath")"
echo "Last modified: $(stat -c %y "$filepath")"

# Count words and lines
words=$(wc -w < "$filepath")
lines=$(wc -l < "$filepath")
echo "Words: $words"
echo "Lines: $lines"

