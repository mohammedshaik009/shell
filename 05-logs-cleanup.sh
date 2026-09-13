#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14} # default to 14 days

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR::Missing parameters"
    echo "USAGE: $0 <source_dir> [days(optional to 14)]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR::directory $SOURCE_DIR does not exist"
    exit 1
fi

echo "Scanning $SOURCE_DIR for log files older than $DAYS days"
FILES=$(find "$SOURCE_DIR" -type "*.log" -name f -mtime +"$DAYS")

if [ -z "$FILES" ]; then
    echo "No log files older than $DAYS days found"
    exit 0
fi

while IFS= read -r FILE
do
    echo "File to be deleted: $FILE"
    rm -f "$FILE"
    echo "File $FILE deleted"
done <<< "$FILES"