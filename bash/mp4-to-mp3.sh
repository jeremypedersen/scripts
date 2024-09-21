#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg could not be found, please install it first."
    exit
fi

# Check if the input file is provided
if [ -z "$1" ]
then
    echo "Usage: $0 input_file.mp4 [output_file.mp3]"
    exit 1
fi

# Input file
input_file="$1"

# Output file
if [ -z "$2" ]
then
    # Default output file name based on input file
    output_file="${input_file%.*}.mp3"
else
    output_file="$2"
fi

# Convert mp4 to mp3
ffmpeg -i "$input_file" -q:a 0 -map a "$output_file"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
fi
