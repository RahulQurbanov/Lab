# Run on vm-iis after copying the publish folder to C:\inetpub\labapp (Lab 1.1 Step 9)
Import-Module WebAdministration
Stop-Website -Name "Default Web Site" -ErrorAction SilentlyContinue
New-WebAppPool -Name "LabAppPool"
Set-ItemProperty IIS:\AppPools\LabAppPool -Name managedRuntimeVersion -Value ""   # No Managed Code

# Makes the app load appsettings.IaaS.json (connection string to vm-sql)
& "$env:windir\system32\inetsrv\appcmd.exe" set config -section:system.applicationHost/applicationPools `
  "/+[name='LabAppPool'].environmentVariables.[name='ASPNETCORE_ENVIRONMENT',value='IaaS']" /commit:apphost

New-Website -Name "LabApp" -PhysicalPath "C:\inetpub\labapp" -Port 80 -ApplicationPool "LabAppPool"
New-NetFirewallRule -DisplayName "HTTP 80" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
