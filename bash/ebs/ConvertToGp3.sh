aws --region us-west-1 ec2 describe-volumes --query 'Volumes[*].{Id:VolumeId}' --filters "Name=tag:conversion,Values=true" --output text
aws ec2 modify-volume --volume-type gp3 --volume-id "${volume_id}" --region us-west-1
for i in $(aws --region us-west-1 ec2 describe-volumes --query 'Volumes[*].{Id:VolumeId}' --filters "Name=tag:conversion,Values=true" --output text); do echo "Converting Volumes" $i; aws ec2 modify-volume --query 'Volumes[*]' --volume-type gp3 --region us-west-1 $i; sleep 1; done;

