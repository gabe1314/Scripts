from os import times
import boto3 
import time
import json


ec2 = boto3.client('ec2')

def lambda_handler(event, context):
# create VPC
vpc = ec2.create_vpc(CidrBlock='172.25.0.0/24')
# # we can assign a name to vpc, or any resource, by using tag
#vpc.create_tags(Tags=[{"Key": "Name", "Value": VPCName}])
# vpc.wait_until_available()
vpc_id = vpc['Vpc']['VpcId']
create_tags_response = ec2.create_tags(Resources = [vpc_id], Tags = [ {'Key' : 'Name' , 'Value' : 'VPCTest'}])
print("VPC ID : {}".format(vpc_id))

#Get Main Route Table ID 
main_rtid = ec2.describe_route_tables (
      Filters=[
        {
          'Name': 'association.main',
          'Values': [ 'true' ]
        }])
print("Printing the VPC Route Table ID ....")
RouteTableIDMain=main_rtid['RouteTables'][0]['RouteTableId']
print(RouteTableIDMain)

time.sleep(3)


#create an EIP for NAT Gateway
eipnatgwA = ec2.allocate_address(Domain='vpc')
print("EIP for NatGW A : {}".format(eipnatgwA['AllocationId']))


# create then attach internet gateway
ig = ec2.create_internet_gateway()
ig_id = ig['InternetGateway']['InternetGatewayId']
ec2.attach_internet_gateway(InternetGatewayId=ig_id,VpcId=vpc_id)
print("InternetGateway : {}".format(ig_id))


# create a route table and a public route
public_route_table = ec2.create_route_table(VpcId=vpc_id)
public_route_table_id = public_route_table['RouteTable']['RouteTableId']
public_route = ec2.create_route(DestinationCidrBlock='0.0.0.0/0',GatewayId=ig_id,RouteTableId=public_route_table_id)
print("Public Route Table ID : {}".format(public_route_table_id))

# create subnets
publicsubnetA = ec2.create_subnet(AvailabilityZone='us-east-2a',CidrBlock='172.25.0.0/24', VpcId=vpc_id)
publicsubnetB = ec2.create_subnet(AvailabilityZone='us-east-2b',CidrBlock='172.25.0.32/24', VpcId=vpc_id)
public_subnetA_id = publicsubnetA['Subnet']['SubnetId']
public_subnetB_id = publicsubnetB['Subnet']['SubnetId']
print("Public SubnetA ID : {}".format(public_subnetA_id))
print("Public SubnetB ID : {}".format(public_subnetB_id))

privatesubnetA = ec2.create_subnet(AvailabilityZone='us-east-2a',CidrBlock='172.25.0.64/24', VpcId=vpc_id)
privatesubnetB = ec2.create_subnet(AvailabilityZone='us-east-2b',CidrBlock='172.25.0.96/24', VpcId=vpc_id)
private_subnetA_id = privatesubnetA['Subnet']['SubnetId']
private_subnetB_id = privatesubnetB['Subnet']['SubnetId']
print("Private SubnetA ID : {}".format(private_subnetA_id))
print("Private SubnetB ID : {}".format(private_subnetB_id))
    
dbsubnetA = ec2.create_subnet(AvailabilityZone='us-east-2a',CidrBlock='172.25.0.128/24', VpcId=vpc_id)
dbsubnetB = ec2.create_subnet(AvailabilityZone='us-east-2b',CidrBlock='172.25.0.160/24', VpcId=vpc_id)
db_subnetA_id = dbsubnetA['Subnet']['SubnetId']
db_subnetB_id = dbsubnetB['Subnet']['SubnetId']
print("Private SubnetA ID : {}".format(db_subnetA_id))
print("Private SubnetB ID : {}".format(db_subnetB_id))



# associate the public route table with the subnet
public_route_table_associationA = ec2.associate_route_table(SubnetId=public_subnetA_id,RouteTableId=public_route_table_id)
public_route_table_associationB = ec2.associate_route_table(SubnetId=public_subnetB_id,RouteTableId=public_route_table_id)
print("Public Route Table Association ID for Subnet A : {}".format(public_route_table_associationA['AssociationId']))
print("Public Route Table Association ID for Subnet B : {}".format(public_route_table_associationB['AssociationId']))


# create then attach a NAT gateway
ngwsubnetA = ec2.create_nat_gateway(AllocationId=eipnatgwA['AllocationId'],SubnetId=public_subnetA_id)
ngwsubnetA_id = ngwsubnetA['NatGateway']['NatGatewayId']
print("NAT GW in Subnet A : {}".format(ngwsubnetA_id))

time.sleep(60)





## Updates Main Route Table to send traffic to the NAT Gateway by making a new route table but sending the traffic to the main table based off line 17 Get Main Route Table ID 
private_route_table_A = ec2.create_route_table(VpcId=vpc_id, TagSpecifications =[
        {
            'ResourceType': 'route-table',
            'Tags': [
                {
                    'Key': 'Name',
                    'Value': 'CustomRouteTable'
                },
            ]
        },
    ]
)
private_route_table_A_id = private_route_table_A['RouteTable']['RouteTableId']
private_route_A = ec2.create_route(DestinationCidrBlock='0.0.0.0/0',NatGatewayId=ngwsubnetA_id,RouteTableId=RouteTableIDMain)
print("Private Route Table A ID : {}".format(RouteTableIDMain))

### This then deletes the Custom Route table which is not needed 
response = ec2.describe_route_tables (
      Filters=[
        {
          'Name': 'tag:Name',
          'Values': [ 'CustomRouteTable' ]
        }])
print("Printing the VPC Route Table ID ....")
RouteTableIDCustom=response['RouteTables'][0]['RouteTableId']
print(RouteTableIDCustom)

delete_custom_rt = ec2.delete_route_table(
    RouteTableId=RouteTableIDCustom
)
print("Custom Route Table Deleted : {}".format(RouteTableIDCustom))
    
       
