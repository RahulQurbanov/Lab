# T120M157 Cloud Computing Services - Laboratory work 1
Name: ______  Group: ______  Date: ______

## 1. Lab 1.1 IaaS - resource specification
| Name | Role | Size (vCPU/RAM) | OS image | Disk | Region | Private IP | Public IP | NSG rules |
|---|---|---|---|---|---|---|---|---|
| vm-dc | AD DC | | Win Server 2019 | | | 10.0.0.4 | | RDP |
| vm-sql | SQL Server | | Win Server 2019 | | | 10.0.0.5 | | RDP |
| vm-iis | IIS | | Win Server 2019 | | | 10.0.0.6 | | RDP, HTTP |
VNet: vnet-lab 10.0.0.0/16, DNS 10.0.0.4

Screenshots: AD promotion, domain join, SQL installed, IIS installed, app running, SELECT * FROM Todos.

## 2. Lab 1.2 PaaS - resource specification
App Service plan (tier, region, OS), Web App name/runtime, SQL server name, DB tier, firewall rules.
Screenshots: local run, Azure SQL created, connection string, published app, Query editor result.

## 3. IaaS vs PaaS comparison
Setup time / OS management / cost / scalability / security control.

## 4. Conclusion
