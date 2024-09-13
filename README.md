# Azure-Terraform-WebApp

Trying to build 3 tier scalable and cost efficient web app in Azure with terraform

Azure Key Vault will be used for secrets management. 
Azure Storage Account will is used for state storage. 
Application Insights is used for monitoring. 

# Explaining the Terraform Files
An additional Azure Storage Account is created to store log data, including Key Vault diagnostic log data. 
I will also be using VSCode with the Terraform extension and the VSCode terminal. 

[Provider](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/provider.tf) - 
Hashcorp minimum version 4.0.1. 
This file defines the Azure provider required for this project, using the azurerm provider version 4.0.1. It provisions a storage account and container to securely store Terraform's state file, ensuring that infrastructure changes are tracked. Additionally, the provider configuration includes a subscription ID, allowing Terraform to interact with Azure resources under the correct account.

[appserviceplan.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/appserviceplan.tf) -
appserviceplan.tf
This file configures two separate Azure App Service Plans: one for the frontend and one for the backend. Both plans use a Linux OS and the "S1" SKU, which supports Availability Zones for scaling and redundancy. Dependencies are set to ensure that the app service plans are created only after the required subnets are provisioned.

[azurewebsite.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/azurewebsite.tf) - 
This file defines two primary resources: the frontend Linux web app and the backend Function App. The web app uses Node.js (version 20 LTS) and is secured by HTTPS-only traffic. It is also linked to Application Insights for monitoring. The backend Function App, built in Python (version 3.12), is secured by Virtual Network integration and restricts access to the frontend subnet. Both apps use system-assigned identities to access other Azure resources.

[config.tfvars](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/config.tfvars)
This file defines two primary resources: the frontend Linux web app and the backend Function App. The web app uses Node.js (version 20 LTS) and is secured by HTTPS-only traffic. It is also linked to Application Insights for monitoring. The backend Function App, built in Python (version 3.12), is secured by Virtual Network integration and restricts access to the frontend subnet. Both apps use system-assigned identities to access other Azure resources.

[database.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/database.tf)
This file manages an Azure SQL Server and database. A random complex password is generated to ensure security. Additionally, a virtual network rule is created to restrict access to the backend subnet only. The file also creates a SQL database and defines its parameters, including size, collation, and environment tags.


[keyvault.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/keyvault.tf)
This file provisions an Azure Key Vault, enabling disk encryption and setting retention policies for deleted secrets. It configures access policies, granting specific users and applications permissions to access keys and secrets. Additionally, Key Vault logging is enabled using Azure Monitor Diagnostic Settings.

[logging.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/logging.tf)
This file creates an Azure Log Analytics workspace for storing diagnostic logs and Application Insights to monitor the performance of the frontend web app and backend Function App. Both resources enable detailed telemetry collection for analysis and diagnostics.

[main.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/main.tf)
This file defines the Azure Resource Group where all other resources are provisioned. Tags are also added for environment and team categorization.

[outputs.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/outputs.tf)
This file provides output values that are useful for interacting with the infrastructure. It outputs the resource group ID, the URLs for both the frontend and backend apps, and the Application Insights instrumentation key.


[variables.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/variables.tf)
This file declares variables used across other Terraform files, such as the resource_group_name and location. It allows for easy customization by centralizing configuration values.

[vnet.tf](https://github.com/OklenCodes/Azure-Terraform-WebApp/blob/main/vnet.tf)
This file creates an Azure Virtual Network and subnets for the frontend and backend. The subnets are configured with service endpoints, allowing secure communication between web services and the SQL database. Delegations for each subnet are defined to manage which services can connect to the subnets.


# Steps to Set Up
First within the Azure console I have to create "OklenAzure1" resource group 
Within the resource group I also create the storage account named "oklenstorageaccount"
Within the storage account, I also create a container named "oklencontainer1"


# Next steps
Looking to explore Azure App Service autoscaling plans to automatically adjust resource allocation based on traffic.
Looking to Implement Azure Application Gateway or Load Balancer to distribute traffic across multiple instances of my app services.
Consider deploying your app services across different availability zones for redundancy.
For your database, explore Azure SQL Database geo-replication for disaster recovery.
