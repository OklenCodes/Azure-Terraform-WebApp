resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Enviroment = "Task 1"
    Team       = "Cloud"
  }

}
