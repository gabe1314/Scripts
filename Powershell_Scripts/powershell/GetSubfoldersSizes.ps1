 gci -force 'O:\Users4'-ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
$len = 0
gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
$_.fullname, '{0:N2} GB' -f ($len / 1Gb)
} > c:\users\adm-gsandoval1\Desktop\users4DirectorySize.csv 
