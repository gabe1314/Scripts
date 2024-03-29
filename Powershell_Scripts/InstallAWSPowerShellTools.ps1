 Function InstallAWSToolsforWindowsPowerShell() {

    $AWSPowerShellModuleSourceURL = "http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi"
    $DestinationFolder = "$ENV:homedrive\$env:homepath\Downloads"

    If (!(Test-Path $DestinationFolder))
    {
        New-Item $DestinationFolder -ItemType Directory -Force
    }

    Write-Host "Downloading AWS PowerShell Module from $AWSPowerShellModuleSourceURL"

    try
    {
        Invoke-WebRequest -Uri $AWSPowerShellModuleSourceURL -OutFile "$DestinationFolder\AWSToolsAndSDKForNet.msi" -ErrorAction STOP

        ### MSI install reference: http://www.jonathanmedd.net/2012/07/automate-msi-installations-with-powershell.html
        $msifile = "$DestinationFolder\AWSToolsAndSDKForNet.msi"

        $arguments = @(
                        "/i"
                        "`"$msiFile`""
                        "/qb"
                        "/norestart"
                        )

        Write-Host "Attempting to install $msifile"

        $process = Start-Process -FilePath msiexec.exe -ArgumentList $arguments -Wait -PassThru
        if ($process.ExitCode -eq 0)
        {
            Write-Host "$msiFile has been successfully installed"
        }
        else
        {
            Write-Host "installer exit code  $($process.ExitCode) for file  $($msifile)"
        }
        ###
    }
    catch
    {
        Write-Host $_.Exception.Message
    }
}

InstallAWSToolsforWindowsPowerShell 
