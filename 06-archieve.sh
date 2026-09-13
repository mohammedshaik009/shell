#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #default to 14 days

if [ -z $SOURCE_DIR ] || [ -z $DEST_DIR ]; then
    echo "ERROR::Either source directory  or destination dir empty"
    echo "USAGE:: $0 <source_dir> <dest_dir> [days:default to 14]"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "source directory: $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "dest_directory: $DEST_DIR does not exist"
    exit 1
fi
