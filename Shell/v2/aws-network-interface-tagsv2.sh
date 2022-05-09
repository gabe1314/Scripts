#!/bin/bash

set -e
echo "Gathering Network interfaces ID (ENI), Please standby..."
for ENI in $(aws ec2 describe-instances --instance-id --query 'Reservations[*].Instances[*].[NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId}]' --output text); do 
  echo "${ENI} ..."
   
done 