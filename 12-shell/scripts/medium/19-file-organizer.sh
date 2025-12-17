#!/bin/bash
# Medium Level Script 19: File Organizer
# Organize files by extension

read -p "Enter directory to organize: " target_dir

if [ ! -d "$target_dir" ]; then
    echo "Error: Directory not found: $target_dir"
    exit 1
fi

echo "Organizing files in $target_dir by extension..."

for file in "$target_dir"/*; do
    if [ -f "$file" ]; then
        ext="${file##*.}"
        if [ "$ext" = "$file" ]; then
            ext="no-extension"
        fi
        ext_dir="$target_dir/$ext"
        mkdir -p "$ext_dir"
        mv "$file" "$ext_dir/"
        echo "Moved $(basename "$file") to $ext/"
    fi
done

echo "Organization complete!"

