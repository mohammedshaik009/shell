#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #deafult to 14 days

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Either source_dir or dest_dir is Missing"
    echo "USAGE:: $0 <source_dir> <dest_dir> [14(optional default to days)]"
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

echo "scanning for $SOURCE_DIR $DEST_DIR log files older than 14 days"
FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%s-%H-%M-%S")
ARCHEIVE_FILE="$DEST_FILE/logs-archeive-$TIMESTAMP.tar.gz"

tar -czvf "$ARCHEIVE_FILE" $DEST_DIR

if [ $? -eq 0 ]; then
    echo "archeival is success, deleting the files"
        while IFS= read -r FILE
        do
            echo "file is $FILE"
            rm -f "$FILE"
        echo "file $FILE deleted"
done <<< "$FILES"