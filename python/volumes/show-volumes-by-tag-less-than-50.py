import boto3
from pprint import pprint

session=boto3.session.Session(profile_name="default")
ec2_client=session.client(service_name="ec2",region_name="us-east-1")
list_of_volids=[]
f_infra_tag = [{
         'Name': 'tag:Application',
         'Values': ['Infrastructure']
            }]
for each_vol in ec2_client.describe_volumes(Filters=f_infra_tag)['Volumes']:
    list_of_volids.append(each_vol['VolumeId'])


    print ("The list of volids are: " ,list_of_volids)