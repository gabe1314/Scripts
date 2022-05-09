#!/bin/bash

# uses aws cli to lookup instances based on a filter on the Name tag
# $1 is the profile to use
# $2 is the filter to use
# $3 is the output format defaults to 'table'
# $4 is optional, the value doesn't matter but if passed in will result
#    in this function printing out the raw command its about to run
#    for debugging purposes
awslookup() {
  cmd="aws ec2 describe-instances --filters \"Name=tag:Application,Values=AzureDevOps\" --query 'Reservations[].Instances[].[InstanceId,PublicDnsName,PrivateIpAddress,State.Name,InstanceType,join(\`,\`,Tags[?Key==\`Name\`].Value)]' --output ${3:-table}"
  if [ $# -eq 4 ]
  then
    echo "Running $cmd"
  fi
  eval $cmd
}