#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Either source dir or dest dir Missing"
    echo "USAGE:: $0 <source_dir> <dest_dir> [14(optional default to days)]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "dir $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "dir $DEST_DIR does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%d-%H-%M-%S")
ARCHIVE_FILE="$DEST_DIR/logs-archive-$TIMESTAMP.tar.gz"

tar -czvf "$ARCHIVE_FILE" $FILES

if [ $? -eq 0 ]; then
    echo "Archival is success, deleting the files"

    while IFS= read -r FILE
        do
            rm -f "$FILE"
            echo "File $FILE deleted"
        done <<< "$FILES"
    else
        echo "ERROR:Archival is FAILED"
        exit 1
fi