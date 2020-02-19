#!/bin/bash
# Usage of this script run
#       bash delete_orphan_disks.sh <AWS_ACCESS_KEY_ID> <AWS_ACCESS_SECRET> <REGION_FOR_DISKS>

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export region=$3

aws_output=$(aws ec2 describe-volumes --output json --region $region)
orphan_disk_list=$(echo $aws_output | jq '.Volumes[] | select(.State == "available" and .Tags == null and .CreateTime >= "2020-02-06" ) |.VolumeId ')
orphan_disk_count=$(echo $orphan_disk_list | wc -w)

printf "\tPossible orphan disk count: %s" $orphan_disk_count
printf "\n\tList of possible orphan disks for shoot"
printf "\n \t\t%s" $orphan_disk_list
