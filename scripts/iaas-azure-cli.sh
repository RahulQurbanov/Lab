#!/bin/bash
# OPTIONAL: create the IaaS infrastructure with Azure CLI (Cloud Shell) instead of the portal.
RG=rg-lab11-iaas; LOC=northeurope; USER=labadmin; PASS='ChangeMe!12345'

az group create -n $RG -l $LOC
az network vnet create -g $RG -n vnet-lab --address-prefix 10.0.0.0/16 --subnet-name default --subnet-prefix 10.0.0.0/24

for vm in "vm-dc 10.0.0.4" "vm-sql 10.0.0.5" "vm-iis 10.0.0.6"; do
  set -- $vm
  az network nic create -g $RG -n nic-$1 --vnet-name vnet-lab --subnet default --private-ip-address $2
  az vm create -g $RG -n $1 --nics nic-$1 --image Win2019Datacenter --size Standard_B2s \
     --admin-username $USER --admin-password "$PASS" --public-ip-address pip-$1
done

az vm open-port -g $RG -n vm-iis --port 80 --priority 900
# After vm-dc is promoted, set the VNet DNS and restart the other VMs:
# az network vnet update -g $RG -n vnet-lab --dns-servers 10.0.0.4
# az vm restart -g $RG -n vm-sql; az vm restart -g $RG -n vm-iis
# Cleanup:  az group delete -n $RG --yes
