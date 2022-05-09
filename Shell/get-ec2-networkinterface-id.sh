#!/bin/bash

set -e
echo "Gathering Information, Please standby..."
for ENI in $(aws ec2 describe-instances --instance-id --query 'NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId}' --output text); do 
  echo "${eni} ..."
   
done 
