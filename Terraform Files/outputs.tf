output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}
output "frontend_url" {

  value = "${azurerm_linux_web_app.frontend-webapp.name}.azurewebsites.net"
}

output "backedn_url" {

  value = "${azurerm_linux_function_app.backend-fnapp.name}.azurewebsites.net"
}
output "instrumentation_key" {
  value     = azurerm_application_insights.fg-appinsights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value     = azurerm_application_insights.fg-appinsights.id
  sensitive = true
}
