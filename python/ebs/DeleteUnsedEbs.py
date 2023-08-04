import json
import boto3


def lambda_handler(event, context):
    

    AWS_REGION = "us-east-1"
    ec2_resource = boto3.resource('ec2', region_name=AWS_REGION)

    for volume in ec2_resource.volumes.filter(
    Filters=[
        {
            'Name': 'status',
            'Values': [
                'available',
            ]
        }
    ]
    ):
        if volume.state == "available":
         volume_id = volume.id
         volume.delete()
        print(f'Volume {volume_id} successfully deleted')
    else:
        print(f"Can't delete volume attached to EC2 instance")
