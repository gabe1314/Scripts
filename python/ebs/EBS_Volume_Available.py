import boto3
import botocore
import os

ec2_client = boto3.client('ec2', region_name='us-east-1')
response = ec2_client.describe_volumes(Filters=[
        {
            'Name': 'status',
            'Values': [
                'available',
            ]
        },
    ],)
print(" Volumes availble and need to be cleaned up") 
UnUsedEBSVolumes=response['Volumes'][0]['State']

VolumeId=response['Volumes'][0]['VolumeId']
print(VolumeId)
print(UnUsedEBSVolumes)

deleteVolume = ec2_client.delete_volume(
    VolumeId=VolumeId)

print("Completed")



