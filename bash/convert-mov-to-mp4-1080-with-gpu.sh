#!/bin/bash

# Check if a directory was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_with_mov_files>"
    exit 1
fi

DIRECTORY=$1

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist: $DIRECTORY"
    exit 1
fi

# Move to directory
cd "$DIRECTORY" || exit

# Iterate over all .mov files in the given directory
for mov_file in *.mov; do
    # Skip if no .mov files are found
    if [ ! -f "$mov_file" ]; then
        echo "No .mov files found in the directory."
        break
    fi

    echo "Processing file: $mov_file"
    
    # Define the output filename (.mp4)
    mp4_file="${mov_file%.mov}.mp4"

    # Convert the video using FFmpeg with NVENC (assuming 10-bit encoding support), and scale to 1080p
    ffmpeg -i "$mov_file" \
           -c:v hevc_nvenc -preset slow -profile:v main10 -pix_fmt p010le \
           -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" \
           -c:a copy \
           "$mp4_file"

    # Copy metadata from the original .mov file to the new .mp4 file using ExifTool
    exiftool -TagsFromFile "$mov_file" -overwrite_original "$mp4_file"

    echo "Conversion to 1080p and metadata copy completed for: $mov_file"
done
