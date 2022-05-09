#!/bin/bash

set -e
echo "Gathering Network interfaces ID (ENI), Please standby..."

for ENI in $(aws ec2 describe-instances --instance-id  --filters Name=instance-type,Values=x1.16xlarge --query 'Reservations[*].Instances[*].[NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId}]' --output text); do 
   echo "${ENI} ..."
  
done

echo "Gathering Instance ID, Please standby..."

for InstanceId in $(aws ec2 describe-instances  --filters Name=instance-type,Values=x1.16xlarge --query Reservations[*].Instances[*].[InstanceId] --output text); do 
  echo "${InstanceId} ..."

  done

