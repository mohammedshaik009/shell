#!/bin/bash

AMI_ID="0220d79f3f480ecf5"
ZONE_ID="Z083970011QGFE38SJQH9"
DOMAIN_NAME=mohammed.world
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
###Validation###
if [ $# -lt 2 ]; then
    echo "ERROR :: at least 2 arguments required"
    echo "usage: $0 create/delete [instance1] [instance2]..."
fi


