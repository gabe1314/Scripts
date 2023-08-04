import boto3

session=boto3.session.Session(profile_name="default")
ec2_client=session.client(service_name="ec2",region_name="us-east-1")
all_regions=[]
for each_region in ec2_client.describe_regions()['Regions']:
    all_regions.append(each_region.get('RegionName'))

for each_region in all_regions:
    print("Working on {}".format(each_region))
    ec2_client=session.client(service_name="ec2",region_name=each_region)