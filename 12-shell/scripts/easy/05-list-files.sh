#!/bin/bash
# Easy Level Script 5: List Files
# List files in a directory

read -p "Enter directory path (default: current): " dir
dir=${dir:-.}

if [ -d "$dir" ]; then
    echo "Files in $dir:"
    ls -lh "$dir"
else
    echo "Directory does not exist: $dir"
fi

