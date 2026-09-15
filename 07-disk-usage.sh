#!/bin/bash

#!/bin/bash

DISK_USAGE=$(df -HT | grep -v Filesystem)

while IFS= read -r line
do
    echo $line
done <<< "$DISK_USAGE"