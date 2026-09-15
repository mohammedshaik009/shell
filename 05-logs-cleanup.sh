#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14} #default to 14 days

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR:: Missing parameters"
    echo "USAGE:: $0 <source_dir> [days(optional to 14)]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "directory $SOURCE_DIR does not exist"
    exit 1
fi

echo "scanning "$SOURCE_DIR" log files older than 14 days"
FILES=$( find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS )

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "file is $FILE"
    rm -f "$FILE"
    echo "file is $FILE deleted"
done <<< "$FILES"