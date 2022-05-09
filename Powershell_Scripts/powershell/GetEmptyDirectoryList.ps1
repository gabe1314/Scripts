 Get-ChildItem -Directory o:\users4 | Where-Object { $_.GetFileSystemInfos().Count -eq 0 } > c:\users\adm-gsandoval1\desktop\emptydirectories2.csv 
