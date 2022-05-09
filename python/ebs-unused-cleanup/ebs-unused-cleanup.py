import boto3


ec2 = boto3.client('ec2')
response = ec2.describe_volumes ()
print(response)


#conn = ec2.connect_to_region('us-east-2')

#vols = conn.get_all_volumes(filters={'status': 'available'})
#print(vols)
#for vol in vols:
#    print('checking vol:', vol.id, 'status:', vol.status, 'attachment_id:', vol.attach_data.status)
#    conn.delete_volume(vol.id)

