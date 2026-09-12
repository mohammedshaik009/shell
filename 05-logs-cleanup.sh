#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14} #default to 14 days

if [ -z $SOURCE_DIR ]; then
    echo "ERROR::Missing parameters"
    echo "USAGE: $0 <source_dir> [days(optional to 14)]"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "ERROR::directory does not exist"
    exit 1
fi

echo "scanning $SOURCE_DIR for no log files older 14 days"
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -z $FILES ]; then
    echo "no log files older 14 days found"
    exit 0
fi

while IFS= read -r FILE
do
    echo "Files to deleted: $FILE"
    rm -f 
    echo "Files $FILE deleted"
done <<< $FILES