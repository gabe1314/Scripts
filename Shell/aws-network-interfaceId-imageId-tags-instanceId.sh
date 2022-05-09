#!/bin/bash

set -e
echo "Gathering Information, Please standby..."
for ENI in $(aws ec2 describe-instances --instance-id --query 'Reservations[*].Instances[*].[InstanceId,ImageId,VpcId,NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId},Tags[*]]' --output text); do 
  echo "${ENI} ..."
   
done 







