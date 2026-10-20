# Run on vm-sql and vm-iis (Lab 1.1 Step 5). VNet DNS must be 10.0.0.4 and VMs restarted first.
nslookup lab.local
Add-Computer -DomainName "lab.local" -Credential (Get-Credential LAB\labadmin) -Restart
