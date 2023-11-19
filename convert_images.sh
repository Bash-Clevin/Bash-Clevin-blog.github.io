#!/bin/bash

read -p "Enter the file path: " filepath

# Extract the directory path
directory=$(dirname -- "$filepath")

# Extract the file name without extension
filename_with_ext=$(basename -- "$filepath")
filename="${filename_with_ext%.*}"

# Extract the file extension
extension="${filepath##*.}"

if [ "$extension" == "png" ]; then
  echo "Processing png file"
  cwebp -lossless $filepath -o $directory/$filename.webp
  echo "Removing the original png file"
  rm $filepath
else
  echo "Processing file"
  cwebp -q 100 $filepath -o $directory/$filename.webp
  echo "Removing the original jpg file"
  rm $filepath
fi