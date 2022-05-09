aws ec2 describe-instances --instance-id --query 'Reservations[*].Instances[*].[NetworkInterfaces[*].{NetworkinterfaceID:NetworkInterfaceId}]' --output text


aws ec2 describe-instances --filters Name=instance-type,Values=t2.micro --query Reservations[*].Instances[*].[InstanceId] --output text