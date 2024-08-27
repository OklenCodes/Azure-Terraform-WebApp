terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
    }
  }
  # here i am storing the state file 
  backend "azurerm" {
    resource_group_name  = "myTFResourceGroup"
    storage_account_name = "statestoragetf"
    container_name       = "statecon"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}
