#!/bin/bash

# Check if a directory path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Change to the specified directory
cd "$1" || exit 1

# Find and rename files with uppercase extensions
for file in *.*; do
    # Check if the filename contains uppercase characters
    if [[ $file =~ [A-Z] ]]; then
        # Extract the filename and extension
        filename="${file%.*}"
        extension="${file##*.}"
        
        # Check if the extension is uppercase
        if [[ $extension =~ [A-Z] ]]; then
            # Convert the extension to lowercase
            new_extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
            new_filename="${filename}.${new_extension}"
            
            # Rename the file
            mv "$file" "$new_filename"
            echo "Renamed $file to $new_filename"
        fi
    fi
done
