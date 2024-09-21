#!/bin/bash

# Check if a directory is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory=$1

# Check if the provided directory exists
if [ ! -d "$directory" ]; then
    echo "The specified path is not a directory."
    exit 1
fi

# Loop through all PNG files in the directory
for file in "$directory"/*.png; do
    if [ ! -f "$file" ]; then
        continue
    fi

    # Extract 'Date/Time Original' using exiftool
    datetime_original=$(exiftool -DateTimeOriginal -d "%Y-%m-%d-%H-%M-%S" "$file" | awk -F': ' '{print $2}')

    if [ -n "$datetime_original" ]; then
        # Construct new file name with date and time
        new_filename="${datetime_original}.png"
        new_filepath="${directory}/${new_filename}"

        # Rename the file
        mv "$file" "$new_filepath"
        echo "Renamed $file to $new_filepath"
    else
        echo "No 'Date/Time Original' EXIF data found for $file"
    fi
done
