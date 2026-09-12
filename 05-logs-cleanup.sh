#!/bin/bash

SOURCE_DIR=$1
DAYS=${2:-14} #default to 14 days

if [ -z $SOURCE_DIR ]; then
    echo "ERROR::Missing parameters"
    echo "USAGE:: $0 <source_dir> [days(optional default to 14)]"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "ERROR:: file $SOURCE_DIR does not exist"
    exit 1
fi
echo "scanning $SOURCE_DIR for log files older than 14 days"
