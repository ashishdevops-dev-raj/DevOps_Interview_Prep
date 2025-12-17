#!/bin/bash
# Easy Level Script 6: Count Lines in File
# Count the number of lines in a file

read -p "Enter file path: " filepath

if [ -f "$filepath" ]; then
    line_count=$(wc -l < "$filepath")
    echo "Number of lines in $filepath: $line_count"
else
    echo "File does not exist: $filepath"
fi

