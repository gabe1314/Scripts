 (New-Object Net.WebClient).DownloadFile('https://s3.amazonaws.com/ec2-windows-drivers-downloads/AWSPV/Latest/AWSPVDriver.zip','D:\Tools\AWSPVDriver.zip');(new-object -com shell.application).namespace('D:\Tools').CopyHere((new-object -com shell.application).namespace('D:\Tools\AWSPVDriver.zip').Items(),16) 
msiexec /i D:\Tools\AWSPVDriverSetup.msi /quiet /log D:\Tools\AWSPVDriverLog.log 

