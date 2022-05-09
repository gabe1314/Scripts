@Echo off
Echo This script installs the following IIS Components. Please validate and proceed with the installation. If any components are not required or additional components are needed, please Add/Remove them manually after this install.
Echo IIS-WebServerRole
Echo  IIS-WebServer
Echo 	IIS-CommonHttpFeatures
Echo 		IIS-StaticContent
Echo 		IIS-DefaultDocument
Echo 		IIS-HttpErrors
Echo 	IIS-ApplicationDevelopment
Echo 		IIS-ASPNET
Echo 		IIS-NetFxExtensibility
Echo 		IIS-ASP
Echo 		IIS-CGI
Echo 		IIS-ISAPIExtensions
Echo 		IIS-ISAPIFilter
Echo 	IIS-HealthAndDiagnostics
Echo 		IIS-HttpLogging
Echo 		IIS-RequestMonitor
Echo 		IIS-HttpTracing
Echo 	IIS-Security
Echo 		IIS-RequestFiltering
Echo 		IIS-WindowsAuthentication
Echo 	IIS-Performance
Echo 		IIS-HttpCompressionStatic
Echo 	IIS-WebServerManagementTools
Echo 		IIS-ManagementConsole
Echo.

Set /p ans=Proceed with IIS Installation? [Y/N]^>
If "%ans%"==Y or y (
GoTo :Install
) Else (
GoTo :EOF
)

:Install
start /w pkgmgr /iu:IIS-WebServerRole;IIS-WebServer;IIS-CommonHttpFeatures;IIS-StaticContent;IIS-DefaultDocument;IIS-HttpErrors;IIS-ApplicationDevelopment;IIS-ASPNET;IIS-NetFxExtensibility;IIS-ASP;IIS-CGI;IIS-ISAPIExtensions;IIS-ISAPIFilter;IIS-HealthAndDiagnostics;IIS-HttpLogging;IIS-RequestMonitor;IIS-HttpTracing;IIS-Security;IIS-RequestFiltering;IIS-WindowsAuthentication;IIS-Performance;IIS-HttpCompressionStatic;IIS-WebServerManagementTools;IIS-ManagementConsole;
Set MOVETO=E:\

REM Backup IIS config before we start changing config to point to the new path
%windir%\system32\inetsrv\appcmd add backup iis_backup_%Date:~-10,2%_%Date:~-7,2%_%Date:~-4,4%_%Time:~0,2%_%Time:~3,2%

REM Stop all IIS services
iisreset /stop

REM Copy all content 
REM /O - copy ACLs
REM /E - copy sub directories including empty ones
REM /I - assume destination is a directory
REM /Q - quiet
REM /Y - Overwrite if already existing

REM echo on, because user will be prompted if content already exists.
echo on
rem xcopy %systemdrive%\inetpub %MOVETO%WebApps /O /E /I /Q
xcopy %systemdrive%\inetpub %MOVETO%WebApps /O /E /I /Q /Y

REM Move AppPool isolation directory 
reg add HKLM\System\CurrentControlSet\Services\WAS\Parameters /v ConfigIsolationPath /t REG_SZ /d %MOVETO%WebApps\temp\appPools /f

REM Move logfile directories
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/sites -siteDefaults.traceFailedRequestsLogging.directory:"%MOVETO%LogFiles\FailedReqLogs"
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/sites -siteDefaults.logfile.directory:"%MOVETO%LogFiles\WebLogs" /siteDefaults.logFile.localTimeRollover:"true"
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/log -centralBinaryLogFile.directory:"%MOVETO%LogFiles\WebLogs"
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/log -centralW3CLogFile.directory:"%MOVETO%LogFiles\WebLogs"
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/sites -siteDefaults.logfile.logExtFileFlags:"Date, Time, ClientIP, UserName, SiteName, ComputerName, ServerIP, Method, UriStem, UriQuery, HttpStatus, Win32Status, BytesSent, BytesRecv, TimeTaken, ServerPort, UserAgent, ProtocolVersion, Host, HttpSubStatus"
%windir%\system32\inetsrv\appcmd set config -section:system.applicationHost/applicationPools /applicationPoolDefaults.recycling.logEventOnRecycle:"Time, Requests, Schedule, Memory, IsapiUnhealthy, OnDemand, ConfigChange, PrivateMemory"

REM Move config history location, temporary files, the path for the Default Web Site and the custom error locations
%windir%\system32\inetsrv\appcmd set config -section:system.applicationhost/configHistory -path:%MOVETO%WebApps\History
%windir%\system32\inetsrv\appcmd set config -section:system.webServer/asp -cache.disktemplateCacheDirectory:"%MOVETO%WebApps\temp\ASP Compiled Templates"
%windir%\system32\inetsrv\appcmd set config -section:system.webServer/httpCompression -directory:"%MOVETO%WebApps\temp\IIS Temporary Compressed Files"
%windir%\system32\inetsrv\appcmd set vdir "Default Web Site/" -physicalPath:%MOVETO%WebApps\wwwroot
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='401'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='403'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='404'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='405'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='406'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='412'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='500'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='501'].prefixLanguageFilePath:%MOVETO%WebApps\custerr
%windir%\system32\inetsrv\appcmd set config -section:httpErrors /[statusCode='502'].prefixLanguageFilePath:%MOVETO%WebApps\custerr

REM Make sure Service Pack and Hotfix Installers know where the IIS root directories are
Reg add HKLM\Software\Microsoft\inetstp /v PathWWWRoot /t REG_SZ /d %MOVETO%WebApps\WWWRoot /f 
Reg add HKLM\Software\Microsoft\inetstp /v PathFTPRoot /t REG_SZ /d %MOVETO%WebApps\FTPRoot /f
REM Do the same for x64 directories
if not "%ProgramFiles(x86)%" == "" Reg add HKLM\Software\Wow6432Node\Microsoft\inetstp /v PathWWWRoot /t REG_EXPAND_SZ /d %MOVETO%WebApps\wwwroot /f 
if not "%ProgramFiles(x86)%" == "" Reg add HKLM\Software\Wow6432Node\Microsoft\inetstp /v PathFTPRoot /t REG_EXPAND_SZ /d %MOVETO%WebApps\ftproot /f

REM Restart all IIS services
iisreset /start
echo.
echo.
echo ===============================================================================
echo Moved IIS7 root directory from %systemdrive%\ to %MOVETO%.
echo.
echo Please verify if the move worked. If so you can delete the %systemdrive%\WebApps directory.
echo If something went wrong you can restore the old settings via 
echo     "APPCMD restore backup beforeRootMove" 
echo and 
echo     "REG delete HKLM\System\CurrentControlSet\Services\WAS\Parameters\ConfigIsolationPath"
echo ===============================================================================
echo.
echo Creating Standard folders for common server functions.
md %MOVETO%Backup
md %MOVETO%SSLCertificates
md %MOVETO%Perfmon
md %MOVETO%Tivoli_Inv
md %MOVETO%Batch
md %MOVETO%Services
rem xcopy /E \\g2vpseg01\CPQIS1\AdminTools %MOVETO%AdminTools\

:EOF
pause