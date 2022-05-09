import boto3
import botocore
import os

ec2_client = boto3.client('ec2', region_name='us-west-2')
response = ec2_client.describe_volumes(Filters=[{'Name': 'tag:Environment', 'Values': ['Production']}])



for result in response['Volumes']:
    VolumeId = result['VolumeId']
    VolumeType = result['VolumeType']
    try:
        if VolumeType == 'gp2':
            modify = ec2_client.modify_volume(VolumeId=VolumeId,VolumeType='gp3')
            print(f"{VolumeId} changed to gp3")
        else:
            print(f"{VolumeId} Not a GP2 Volume Type") 
    except boto.execptions.ClientError as error:
        print(error)    

