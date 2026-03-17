output "azurerm_resource_group" {
  description = "Azure resource group name"
  value       = azurerm_resource_group.tfstate.name
}


output "azurerm_storage_container" {
  description = "Azure storage container name"
  value       = azurerm_storage_container.tfstate.name
}

output "azurerm_storage_account" {
  description = "Azure storage account name"
  value       = azurerm_storage_account.tfstate.name
}

