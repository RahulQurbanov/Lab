# Run on vm-iis (Lab 1.1 Step 7)
Install-WindowsFeature Web-Server, Web-Mgmt-Console, Web-Asp-Net45 -IncludeManagementTools
# Install the .NET 8 Hosting Bundle (https://dotnet.microsoft.com/download/dotnet/8.0), then:
iisreset
