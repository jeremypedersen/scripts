#!/bin/bash

# Check if a directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Directory containing .jpg and .jpeg files (passed as first argument)
DIRECTORY="$1"

# Change to the directory
cd "$DIRECTORY" || exit

# Iterate over each .jpg and .jpeg file in the directory
for file in *.{png,PNG}; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Extract the date and time the image was taken using exiftool
        # Format includes seconds
        datetime=$(exiftool -s -s -s -d "%Y-%m-%d-%H-%M-%S" -CreateDate "$file")

        # Check if datetime was successfully extracted
        if [ -n "$datetime" ]; then
            # Rename the file
            # The file extension is preserved using the following method
            echo "Renaming $file..."
            extension="${file##*.}"
            mv "$file" "${datetime}.png"
        else
            echo "Date and time could not be extracted for $file"
        fi
    fi
done
