# copy the .exe from the S3 bucket to the EC2 instance
$isEXEKitOnEC2Instance = Test-Path “D:\Tools\AWSAgentInstall.exe”
if ($isEXEKitOnEC2Instance -eq $false)
{
echo “Copying the kit from the S3 bucket to the EC2 instance.”
Copy-S3Object -BucketName sigue-inspector-agent -Key AWSAgentInstall.exe -LocalFile D:\Tools\AWSAgentInstall.exe
# delay the next command with 10 seconds (this will give time for the .exe to be copied)
Start-Sleep -s 10
echo “The ,exe has been copied to the EC2 instance.”
}
else
{
echo “The kit is already on the EC2 instance and will not be copied anymore.”
}

# check if the .exe is already installed on the machine
$isExeInstalled = Test-Path “C:\Program Files\Amazon Web Services\AWS Agent\AWSAgent.exe”
if ($isExeInstalled -eq $false)
{
echo “The .exe is not installed. Install is in progress…”
# run the .exe on the remote machine in silent mode
Invoke-Expression “D:\Tools\AWSAgentInstall.exe /S”
}
else
{
echo “The .exe is already installed.”
}