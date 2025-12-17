#!/bin/bash
# Medium Level Script 17: Text Processor
# Process text files with various operations

read -p "Enter file path: " filepath

if [ ! -f "$filepath" ]; then
    echo "Error: File not found: $filepath"
    exit 1
fi

echo "=== Text Processing Options ==="
echo "1. Count words"
echo "2. Count lines"
echo "3. Count characters"
echo "4. Find unique words"
echo "5. Sort lines"
read -p "Select option (1-5): " option

case $option in
    1)
        echo "Word count: $(wc -w < "$filepath")"
        ;;
    2)
        echo "Line count: $(wc -l < "$filepath")"
        ;;
    3)
        echo "Character count: $(wc -c < "$filepath")"
        ;;
    4)
        echo "Unique words (first 20):"
        tr '[:space:]' '\n' < "$filepath" | sort -u | head -20
        ;;
    5)
        echo "Sorted lines (first 20):"
        sort "$filepath" | head -20
        ;;
    *)
        echo "Invalid option"
        ;;
esac

