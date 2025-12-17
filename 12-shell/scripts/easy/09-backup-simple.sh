#!/bin/bash
# Easy Level Script 9: Simple Backup
# Create a simple backup of a file

read -p "Enter file to backup: " source_file

if [ -f "$source_file" ]; then
    backup_file="${source_file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$source_file" "$backup_file"
    echo "Backup created: $backup_file"
else
    echo "File does not exist: $source_file"
fi

