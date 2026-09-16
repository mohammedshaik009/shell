#!/bin/bash

DISK_USAGE=$(df -HT | grep -v Filesystem)
USAGE_THRESHOLD=10

while IFS= read -r line
    do
    echo $line
done <<< $DISK_USAGE