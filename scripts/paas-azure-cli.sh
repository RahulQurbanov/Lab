#!/bin/bash
# OPTIONAL: create the PaaS resources with Azure CLI (Cloud Shell). Names must be globally unique - change SUFFIX.
SUFFIX=yourname123; RG=rg-lab12-paas; LOC=northeurope
SQLSRV=sql-lab-$SUFFIX; APP=app-lab-$SUFFIX; ADMIN=sqladmin; PASS='ChangeMe!12345'

az group create -n $RG -l $LOC
az sql server create -g $RG -n $SQLSRV -l $LOC -u $ADMIN -p "$PASS"
az sql server firewall-rule create -g $RG -s $SQLSRV -n AllowAzure --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
az sql db create -g $RG -s $SQLSRV -n TodoDb --edition Basic

az appservice plan create -g $RG -n plan-lab --sku B1
az webapp create -g $RG -p plan-lab -n $APP --runtime "dotnet:8"

az webapp config connection-string set -g $RG -n $APP -t SQLAzure --settings \
  DefaultConnection="Server=tcp:$SQLSRV.database.windows.net,1433;Database=TodoDb;User ID=$ADMIN;Password=$PASS;Encrypt=True;TrustServerCertificate=False;"

# Deploy (run from the LabApp folder):
#   dotnet publish -c Release -o publish && (cd publish && zip -r ../app.zip .)
#   az webapp deploy -g $RG -n $APP --src-path app.zip --type zip
echo "https://$APP.azurewebsites.net"
