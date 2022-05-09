import boto3
import botocore
import os

ec2_client = boto3.client('ec2', region_name='us-east-1')
response = ec2_client.describe_volumes(Filters=[
        {
            'Name': 'status',
            'Values': [
                'Available',
            ]
        },
    ],)
print(f"{response} changed to gp3") 

