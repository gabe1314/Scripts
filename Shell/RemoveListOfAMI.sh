#!/bin/bash
 
print "Starting AMI Cleanup, please be patient mofo"
aws ec2 deregister-image --image-id ami-d6db64ac
aws ec2 deregister-image --image-id ami-6d46ea10
aws ec2 deregister-image --image-id ami-b8d768c2  
aws ec2 deregister-image --image-id ami-6246ea1f  
aws ec2 deregister-image --image-id ami-0cc41165d0b7c8fbb
aws ec2 deregister-image --image-id ami-a4b5aedf
aws ec2 deregister-image --image-id ami-2666b55c
aws ec2 deregister-image --image-id ami-a3d970b5 
aws ec2 deregister-image --image-id ami-f0238f8a 
aws ec2 deregister-image --image-id ami-f3f2d6e5 
aws ec2 deregister-image --image-id ami-05fcaa40adbfd767f
aws ec2 deregister-image --image-id ami-069880855e4aebab7
aws ec2 deregister-image --image-id ami-04d18e7f   
aws ec2 deregister-image --image-id ami-86ca95fd  
aws ec2 deregister-image --image-id ami-8bd502f6 
aws ec2 deregister-image --image-id ami-86fd44fc 
aws ec2 deregister-image --image-id ami-0af4231c2c6833eb3
aws ec2 deregister-image --image-id ami-054662494a6f110db
aws ec2 deregister-image --image-id ami-07fb3569b579e8e4f
aws ec2 deregister-image --image-id ami-053603e1d56ebb0e4
aws ec2 deregister-image --image-id ami-05f546a95df39d38e