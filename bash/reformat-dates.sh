#!/bin/bash

# Check if a directory path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Navigate to the specified directory
cd "$1" || { echo "Directory does not exist"; exit 1; }

# Loop through files matching the specified pattern, without specifying the extension
for file in [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]*; do
    if [[ -f "$file" ]]; then
        # Extract the datetime components and original file extension from the filename
        year="${file:0:4}"
        month="${file:4:2}"
        day="${file:6:2}"
        hour="${file:9:2}"
        minute="${file:11:2}"
        second="${file:13:2}"
        extension="${file##*.}"
        
        # Construct the new filename with the original extension
        new_filename="${year}-${month}-${day}-${hour}-${minute}-${second}.${extension}"
        
        # Rename the file
        mv "$file" "$new_filename"
        echo "Renamed $file to $new_filename"
    fi
done
