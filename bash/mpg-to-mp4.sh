#!/bin/bash

# Check if a directory argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/mpg/files"
    exit 1
fi

# Directory containing .MPG and .mpg files
DIRECTORY=$1

# Check if the specified directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Change to the directory
cd "$DIRECTORY"

# Function to convert a single file
convert_file() {
    local FILE=$1
    local OUTPUT_FILE="${FILE%.*}.mp4"

    # Check if the video is already H.264 encoded
    if ffmpeg -i "$FILE" 2>&1 | grep -q "Video: h264"; then
        # Copy the video as is, with metadata
        ffmpeg -i "$FILE" -c:v copy -c:a copy -map_metadata 0 "$OUTPUT_FILE"
    else
        # Transcode to H.264 and copy metadata
        ffmpeg -i "$FILE" -c:v libx264 -preset slow -crf 23 -c:a copy -map_metadata 0 "$OUTPUT_FILE"
    fi
}

# Loop through all .MPG and .mpg files in the directory
for FILE in *.MPG *.mpg; do
    if [ -e "$FILE" ]; then # Check if file exists
        echo "Converting $FILE..."
        convert_file "$FILE"
    fi
done
