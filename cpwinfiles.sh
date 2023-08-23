#!/bin/bash

# List all files in the current directory
all_files=$(ls -A)

# Filter out .git, README.md, and files starting with .aider
filtered_files=$(echo "$all_files" | grep -vE '(\.git|README\.md|\.aider)')

# Output the list of files
echo "$filtered_files"
