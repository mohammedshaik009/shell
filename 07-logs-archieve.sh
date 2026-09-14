#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Either source_dir or Dest_dir Missing"
    echo "USAGE:: $0 <source_dir> <dest_dir> (days[default to 14])"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "directory $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "directory $DEST_DIR does not exist"
    exit 1
fi

echo "scanning for $SOURCE_DIR log files older than $DAYS"
FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0 
fi

TIMESTAMP=$(date "+%Y-%m-%d %H-%M-%S")
ARCHIEVE_FILE="$DEST_DIR/logs-archieve-$TIMESTAMP tar.gz"

tar -czvf "$ARCHIEVE_FILE" $FILES

if [ $? -eq 0 ]; then
    echo "archieval is success"
    while IFS= read -r FILE
        do
            echo "File is $FILE"
            rm -f "$FILE"
            echo "Delete File $FILE"
    done <<< "$FILES"
else
    echo "ERROR:archieval is FAILED"
    exit 1
fi
