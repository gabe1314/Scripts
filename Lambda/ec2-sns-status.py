import json
import boto3
def lambda_handler(event, context):
    ec2_con=boto3.resource("ec2",'us-east-1')
    sns_client=boto3.client('sns','us-east-1')
    my_ins=ec2_con.Instance('i-0473e4040f7ad3177')
    print my_ins.state['Name']
    
    sns_client.publish(TargetArn="arn:aws:sns:us-east-1:765032730250:StatusOfEc2",Message=my_ins.state['Name'])