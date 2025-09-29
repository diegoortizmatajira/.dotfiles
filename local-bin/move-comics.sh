#!/bin/bash

# Set your source and destination folders
SOURCE_DIR="/home/storage/Inbox/Usenet/Comics"
DEST_DIR="/home/storage/Diego-Ortiz/Lambton-OneDrive/Apps/ComicTrack/content/import"

# Create destination folder if it doesn't exist
mkdir -p "$DEST_DIR"

# Find and move .cbr and .cbz files
find "$SOURCE_DIR" -type f \( -iname "*.cbr" -o -iname "*.cbz" \) -exec sh -c 'echo "Moving: $1" && mv "$1" "$2"' sh {} "$DEST_DIR" \;

echo "All .cbr and .cbz files have been moved to $DEST_DIR"

cd $SOURCE_DIR

clear-empty-folders
