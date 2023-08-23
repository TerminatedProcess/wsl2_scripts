#!/bin/bash

# Directory to update files from
src_dir="/mnt/c/Development/tools"

# Get list of files in the current directory
files=$(ls -A)

# Iterate over each file
for file in $files; do
  # Check if file exists in the source directory
  if [ -f "$src_dir/$file" ]; then
    # If it does, copy it to the current directory
    cp "$src_dir/$file" "$file"
    echo "Updated $file"
  else
    # If it doesn't, print a message saying the file was not found
    echo "$file not found"
  fi
done
