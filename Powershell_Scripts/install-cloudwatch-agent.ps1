# Install the CloudWatch Agent
$zipfile = "AmazonCloudWatchAgent.zip"
$tempDir = Join-Path $env:TEMP "AmazonCloudWatchAgent"
Invoke-WebRequest -Uri "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip" -OutFile $zipfile
Expand-Archive -Path $zipfile -DestinationPath $tempDir -Force
cd $tempDir
Write-Host "Trying to uninstall any previous version of CloudWatch Agent"
.\uninstall.ps1

Write-Host "install the new version of CloudWatch Agent"
.\install.ps1

$windowsLogs = @("Application", "System", "Security")
$windowsLoglevel = @("ERROR", "INFORMATION")
$instance = hostname


$iissites = Get-Website | Where-Object {$_.Name -ne "Default Web Site"}

$iislogs = @()
foreach ($site in $iissites) {
    $iislog = @{
        file_path = "$($site.logFile.directory)\w3svc$($site.id)\*.log"
        log_group_name = "/iis/$($site.Name.ToLower())"
        log_stream_name = $instance
        timestamp_format = "%Y-%m-%d %H:%M:%S"
        timezone = "UTC"
        encoding = "utf-8"
    }
    $iislogs += $iislog
}

$winlogs = @()
foreach ($event in $windowsLogs) {
    $winlog = @{
        event_name = $event
        event_levels = $windowsLoglevel
        event_format ="text"
        log_group_name = "/eventlog/$($event.ToLower())"
        log_stream_name = $instance
    }
    $winlogs += $winlog
}

$config = @{
    logs = @{
        logs_collected = @{
            files = @{
                collect_list = $iislogs
            }
            windows_events = @{
                collect_list = $winlogs
            }
        }
        log_stream_name = "generic-logs"
    }
}

$configfile = "C:\Users\Administrator\amazon-cloudwatch-agent.json"

Write-Host "Generating AWS CloudWatch configuration file $configfile."

$json = $config | ConvertTo-Json -Depth 6 
$json | Out-File -Force -Encoding oem $configfile


cd "${env:ProgramFiles}\Amazon\AmazonCloudWatchAgent"
Write-Host "Starting CloudWatch Agent"
.\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:$configfile -s

Write-Host "done."