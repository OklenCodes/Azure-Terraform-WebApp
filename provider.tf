terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.1"
    }
  }
  # Storing the state file here
  backend "azurerm" {
    resource_group_name  = "myTFResourceGroup"
    storage_account_name = "statestoragetf"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}
