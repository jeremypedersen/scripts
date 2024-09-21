#!/bin/bash

# Check if directory path is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if the provided argument is a directory
if [ ! -d "$1" ]; then
    echo "$1 is not a directory."
    exit 1
fi

# Navigate to the directory
cd "$1" || exit

# Find all files and extract their extensions
extensions=$(find . -type f | sed -E 's/.*\.([^.]+)$/\1/' | sort -u)

# Print out unique file extensions
echo "Unique file extensions in $1:"
echo "$extensions"
