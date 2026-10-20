# Run on vm-dc as Administrator (Lab 1.1 Step 2)
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest `
  -DomainName "lab.local" `
  -DomainNetbiosName "LAB" `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssw0rd!2024" -AsPlainText -Force) `
  -InstallDns `
  -Force
# Server reboots. Afterwards log in as LAB\labadmin
