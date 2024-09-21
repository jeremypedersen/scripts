#!/bin/bash

# Check if a directory argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/m4v/files"
    exit 1
fi

# Directory containing .m4v files
DIRECTORY=$1

# Check if the specified directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Change to the directory
cd "$DIRECTORY"

# Loop through all .m4v files in the directory
for FILE in *.m4v; do
    # Check if the file is H.264 and 1080p
    if ffmpeg -i "$FILE" 2>&1 | grep -q "Video: h264" && ffmpeg -i "$FILE" 2>&1 | grep -q "1920x1080"; then
        # Copy the video as is, with metadata
        ffmpeg -i "$FILE" -c copy -map_metadata 0 "${FILE%.m4v}.mp4"
    else
        # Transcode to H.264 1080p and copy metadata
        ffmpeg -i "$FILE" -c:v libx264 -preset slow -crf 23 -s hd1080 -c:a copy -map_metadata 0 "${FILE%.m4v}.mp4"
    fi
done
