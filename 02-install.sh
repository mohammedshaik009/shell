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

ACTION=$1
shift #first argument willbe removes

if [ "$ACTION" != "create" ] && [ "$ACTION" != "delete"]; then
    echo -e "$R ERROR:: First argument must be either create or delete $N"
    echo "usage: $0 create/delete [instance1] [instance2]..."
    exit 1
fi

get_instance_id(){
    name=$1
    aws ec2 describe-instances --filters "Name=tag:Name,Values=roboshop-$instance" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text
}

for instance in $@
do
    INSTANCE_ID=$(get_instance_id $instance)
    if [ $ACTION == "create" ]; then
        if [ $INSTANCE_ID == "None" ]; then
        echo "Launching instance: roboshop-$instance"
        INSTANCE_ID=$(aws ec2 run-instances \
        --image-id ami-0220d79f3f480ecf5 \
        --instance-type t3.micro \
        --security-groups "roboshop-common" "roboshop-$instance" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
        --query 'Instances[0].InstanceId' \
        --output text
        )
        echo "Launched instance: $INSTANCE_ID"
    else
        echo "roboshop $instance is already running: $INSTANCE_ID"
        fi
    fi

done