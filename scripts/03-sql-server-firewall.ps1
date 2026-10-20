# Run on vm-sql after installing SQL Server (Lab 1.1 Step 6)
New-NetFirewallRule -DisplayName "SQL 1433" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow
# Then: SQL Server Configuration Manager -> Network Configuration -> TCP/IP = Enabled -> restart SQL service
