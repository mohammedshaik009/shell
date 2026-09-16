#/bin/bash

DISK_USAGE=$( df -HT | grep -v Filesystem )
USAGE_THRESHOLD=10

while IFS= read -r line
    do
        USAGE=$( echo $line awk '{print $6}' | cut -d "%" -f1 )
        PARTITION=$( echo $line awk '{print $7}')
        if [ $USAGE -ge $USAGE_THRESHOLD ]; then
            MESSAGE=( high disk usage on $USAGE: $PARTITION )
        fi 
    done <<< "$DISK_USAGE"