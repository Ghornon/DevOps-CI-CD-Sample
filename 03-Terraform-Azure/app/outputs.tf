output "public_ip_address" {
  value = azurerm_public_ip.public-ip.ip_address
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}
