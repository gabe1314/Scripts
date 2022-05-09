import boto3

ec2_client = boto3.resource('ec2', region_name='us-east-1')

for volume in ec2_client.volumes.filter(
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
        print(f'Volume {volume_id} successfully deleted unused EBS Volume') 
    else:
        print(f"Can't delete volume attached to ec2 instance")

