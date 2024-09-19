terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.1"
    }
  }
}

  # Storing the state file here
resource "azurerm_storage_account" "state_account" {
  name                     = "oklenstorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  }

resource "azurerm_storage_container" "state" {
  name                  = "oklenstatecontainer"
  storage_account_name  = azurerm_storage_account.state_account.name
  container_access_type = "private"
}


provider "azurerm" {
  features {}

  subscription_id = 
}
