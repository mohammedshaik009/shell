#!/bin/bash

SOURCE_DIR=$1
DAYS=$(2:-14) #default to 14 days

if [ -z $SOURCE_DIR ]; then
    echo "ERROR::Missing parameters"
    echo "USAGE: $0 <source_dir> [days(optional to 14)]"
    exit 1
fi
