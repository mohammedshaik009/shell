#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR::Either source directory  or destination dir empty"
    echo "USAGE:: $0 <source_dir> <dest_dir> [days:default to 14]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "source directory: $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "dest_directory: $DEST_DIR does not exist"
    exit 1
fi

FILES=$( find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS )

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "$FILE"
done <<< "$FILES"

TIMESTAMP=$(date "%Y-%m-%d %H:%M:%S")
ARCHEIVE_FILE=$DEST_DIR-$TIMESTAMP.tar.gz

tar -czvf $ARCHEIVE_FILE $FILES
