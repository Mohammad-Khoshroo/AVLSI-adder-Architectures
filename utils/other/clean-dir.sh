#!/bin/bash

echo "=== Linux Folder Cleaner ==="
read -p "Enter directory path (press Enter for current folder): " TARGET_DIR

if [ -z "$TARGET_DIR" ]; then
    TARGET_DIR="$PWD"
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist!"
    exit 1
fi

echo ""
echo "WARNING: This will delete ALL sub-folders inside: $TARGET_DIR"
echo "Files in the root of this directory will NOT be deleted."
read -p "Press Enter to continue or Ctrl+C to cancel..."

echo ""
echo "Deleting folders..."

for d in "$TARGET_DIR"/*/; do
    if [ -d "$d" ]; then
        echo "Deleting: $d"
        rm -rf "$d"
    fi
done

echo ""
echo "Cleanup Complete!"
