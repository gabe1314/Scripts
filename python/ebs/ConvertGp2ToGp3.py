import boto3

ec2_client = boto3.client('ec2', region_name='us-east-1')

response = ec2_client.describe_volumes(Filters=[{'Name': 'tag:Application', 'Values': ['DREAM']}])

for volume in response['Volumes']:
    ec2_client.modify_volume(VolumeId=volume['VolumeId'], VolumeType='gp3')