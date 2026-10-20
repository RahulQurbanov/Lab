# T120M157 Lab 1 - ASP.NET Core Todo app (IaaS + PaaS)

Needs on your PC: .NET 8 SDK, Visual Studio 2022 (or VS Code), SQL Server LocalDB (ships with Visual Studio).

## Local run (also Lab 1.2 Step 1)
    cd LabApp
    dotnet run
Open http://localhost:5000, add tasks, take a screenshot.

## Lab 1.1 - IaaS (scripts/ folder, in order)
1. Create 3 Windows Server 2019 VMs in one VNet: vm-dc 10.0.0.4, vm-sql 10.0.0.5, vm-iis 10.0.0.6
   (portal, or scripts/iaas-azure-cli.sh).
2. 01-dc-promote.ps1 on vm-dc -> reboot.
3. Set VNet DNS = 10.0.0.4, then restart vm-sql and vm-iis.
4. 02-join-domain.ps1 on vm-sql and vm-iis.
5. Install SQL Server 2019 + SSMS on vm-sql; run 03-sql-server-firewall.ps1; enable TCP/IP in Configuration Manager.
6. 04-install-iis.ps1 on vm-iis, then install the .NET 8 Hosting Bundle and run iisreset.
7. Run 06-sql-permissions.sql in SSMS on vm-sql.
8. On your PC:  cd LabApp ; dotnet publish -c Release -o publish
   Copy the publish folder to vm-iis at C:\inetpub\labapp.
9. 05-iis-site.ps1 on vm-iis (creates the site, sets ASPNETCORE_ENVIRONMENT=IaaS so appsettings.IaaS.json is used).
10. Open http://localhost on vm-iis and http://<vm-iis public IP> from your PC. Then in SSMS:
    SELECT * FROM TodoDb.dbo.Todos;

## Lab 1.2 - PaaS
Portal steps, or scripts/paas-azure-cli.sh. Visual Studio: right-click project -> Publish -> Azure -> Azure App Service.
Connection string is set in App Service -> Environment variables -> Connection strings (type SQLAzure);
it overrides appsettings.json, so no password is stored in code.
Test: https://<app>.azurewebsites.net, then SQL database -> Query editor -> SELECT * FROM Todos.

## Cleanup
Delete resource groups rg-lab11-iaas and rg-lab12-paas when finished (stops all charges).
