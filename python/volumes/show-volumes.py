import boto3
from pprint import pprint

session=boto3.session.Session(profile_name="default")
ec2_client=session.client(service_name="ec2",region_name="us-east-1")

for each_vol in ec2_client.describe_volumes()['Volumes']:
    pprint(each_vol)