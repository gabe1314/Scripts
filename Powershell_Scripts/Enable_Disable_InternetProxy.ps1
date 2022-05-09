$regKey=”HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings”
$proxyServer = “”
$proxyServerToDefine = “10.1.100.195:3228”
Write-Host “Gathering proxy server details…”
$proxyServer = Get-ItemProperty -path $regKey ProxyServer -ErrorAction SilentlyContinue
Write-Host $proxyServer
$val = (get-itemproperty “HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections” DefaultConnectionSettings).DefaultConnectionSettings

$val[8] = $val[8] -bxor 8
if([string]::IsNullOrEmpty($proxyServer))
{
Write-Host “The Proxy is actually disabled”

set-itemproperty “HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections” -name DefaultConnectionSettings -value $val
Set-ItemProperty -path $regKey ProxyEnable -value 1
Set-ItemProperty -path $regKey ProxyServer -value $proxyServerToDefine
Write-Host “The Proxy is now enabled”
}
else
{

set-itemproperty “HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections” -name DefaultConnectionSettings -value $val
Set-ItemProperty -path $regKey ProxyEnable -value 0
Remove-ItemProperty -path $regKey -name ProxyServer

Write-Host “The Proxy is now disabled”
} 
