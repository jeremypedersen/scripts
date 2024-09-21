#!/bin/bash

# Check if an argument is given
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <video-file>"
    exit 1
fi

# Assign the input argument to a variable
input_video="$1"

# Extract the filename without extension
base_name=$(basename "$input_video" | sed 's/\.[^.]*$//')

# Convert video to mp3
ffmpeg -i "$input_video" -q:a 0 -map a "$base_name.mp3"

echo "Conversion complete: $base_name.mp3"
