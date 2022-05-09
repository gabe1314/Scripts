#!bin\bash
aws ec2 describe-instances --region us-east-1 --instance-ids --filters "Name=monitoring-state,Values=disabled" --query 'R
eservations[*].Instances[].[InstanceId, State.Name, Monitoring.State]' --output text|grep running|awk '{print$1}' > /tmp/us-east-1-instances | grep -A 7 765032730250