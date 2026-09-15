#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR::Missing Either source_dir or dest_dir"
    echo "USAGE:: $0 <source_dir> <dest_dir> [14(optional to days)]"
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

echo "scanning for $SOURCE_DIR log files older than 14 days"
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days nothing to do"
    exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%s-%H-%M-%S")
ARCHEIVE_FILE="$DEST_DIR/logs-archeive-$TIMESTAMP.tar.gz"

tar -czvf $ARCHEIVE_FILE $FILES

if [ $? -eq 0 ]; then
    echo "Archieval is success, deleting the files"

while IFS= read -r FILE
do
    rm -f "$FILE"
    echo "file $FILE is deleted"
done <<< "$FILES"
else
    echo "ERROR::Archieval is FAILED"
fi