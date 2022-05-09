# Assume role and note the timestamp - it will be used to check if the token needs renewal
aws_login
alive_since=$(date +%Y-%m-%d-%T)

# Source File Name, will contain all versions of objects in the bucket
SRCFN=/tmp/dump_file
# File Name will list chunks of object versions for deletion in an iteration
FN=/tmp/todelete

# Disable versioning on the bucket so that new versions don't appear as we delete
aws s3 put-bucket-versioning --bucket ap-northeast2-cloudtrail --versioning-configuration Status=Suspended

# Get all versions of all objects in the bucket
# This is what will time out if there's more than 1M objects/versions
aws s3 list-object-versions --bucket ap-northeast2-cloudtrail --output json --query ‘Versions[].{Key: Key, VersionId: VersionId}’ > $SRCFN

index=0
# How many object versions in total??
total=$(grep -c VersionId $SRCFN)

# Go through the list in $SRCFN and delete chucks of 1000 objects until there’s nothing left
while [ $index -lt $total ] ; do
    # Check if it’s been more than 55 minutes since we assumed role
    # Renew if it has, and reset the alive_since timestamp
    CUT_OFF_TIME=$(date --date=’55 minutes ago’ +%Y-%m-%d-%T)
    if [ ${CUT_OFF_TIME} \\> ${alive_since} ]; then
        aws_login
        alive_since=$(date +%Y-%m-%d-%T)
    fi
    ((e=index+999))
    echo “Processing $index to $e”
    # Get a list of objects from $index to $index+999, formatted for the delete-objects AWS API
    (echo -n ‘{“Objects”:’;jq “.[$index:$e]” < $SRCFN 2>&1 | sed ‘s#]$#] , “Quiet”:true}#’) > $FN
    
    # Delete the chunk
    aws s3 delete-objects --bucket ap-northeast2-cloudtrail --delete file://$FN && rm $FN
    
    ((index=e+1))
    sleep 1
done
# Normally by now the bucket is empty, force delete it
aws s3 rb s3://${BUCKET} --force