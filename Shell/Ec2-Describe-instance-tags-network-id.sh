Working 

aws ec2 describe-instances --instance-id i-0cb9b012b8571bfb1  --query 'Reservations[*].Instances[*].[InstanceId,ImageId,Tags[*]]' --output text

aws ec2 describe-instances --instance-id i-0cb9b012b8571bfb1 --query 'Reservations[*].Instances[*].[InstanceId,ImageId,VpcId,NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId},Tags[*]]' --output text

aws ec2 describe-instances --instance-id i-0cb9b012b8571bfb1 --query 'Reservations[*].Instances[*].[InstanceId,ImageId,VpcId,NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId},Tags[*]]' --output text

aws ec2 describe-instances --instance-id --query 'Reservations[*].Instances[*].[InstanceId,ImageId,VpcId,NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId},Tags[*]]' --output text
output

i-0cb9b012b8571bfb1	ami-7d775306	vpc-a6f324c2
eni-e7c05b49
Function	Database Server
Name	U33LKNSDB01
Application	LinkNet
Patch Group	Windows Servers
Environment	UAT