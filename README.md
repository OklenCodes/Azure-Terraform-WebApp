# Azure-Terraform-WebApp

Trying to build 3 tier scalable and cost efficient web app in Azure with terraform

Azure Key Vault will be used for secrets management. 
Azure Storage Account will is used for state storage. 
Application Insights is used for monitoring. 

# Explaining the Terraform Codes

[Provider](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/provider.tf) - 
Hashcorp minimum version 4.0.1. 
Storing the statefile which includes name, location, account tier and account replication. 
Azure storage container, name, storage account name and container access type.

[appserviceplan.tf]
[azurewebsite.tf]
[config.tfvars]
[database.tf]
[keyvault.tf]
[logging.tf]
[main.tf]
[outputs.tf]
[variables.tf]
[vnet.tf]



# Next steps
Looking to explore Azure App Service autoscaling plans to automatically adjust resource allocation based on traffic.
Looking to Implement Azure Application Gateway or Load Balancer to distribute traffic across multiple instances of my app services.
Consider deploying your app services across different availability zones for redundancy.
For your database, explore Azure SQL Database geo-replication for disaster recovery.


An additional Azure Storage Account is created to store log data, including Key Vault diagnostic log data. 
I will also be using VSCode with the Terraform extension and the VSCode terminal. 

# Steps to Set Up
First within the Azure console I have to create "OklenAzure1" resource group 
Within the resource group I also create the storage account named "oklenstorageaccount"
Within the storage account, I also create a container named "oklencontainer1"
