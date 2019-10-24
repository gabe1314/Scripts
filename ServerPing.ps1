# create a file with name "ips.txt" (containing ips and hostnames) put it under folder c:\host
$list = get-content "ip2.txt"
foreach ($ip in $list)
{$result = Get-WmiObject Win32_PingStatus -filter "address='$IP'"
if ($result.statuscode -eq 0)
{
write-host "$IP Server is up"
}
else
{
Write-host "$IP Server is down"
}
}
$collection | Export-Csv -c c:\host\PingResults2.csv -NoTypeInformation