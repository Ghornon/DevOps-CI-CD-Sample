# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "this" {
  name     = var.project_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.project_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.project_name}-internal"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.app_subnet_address_prefixes
}

resource "azurerm_public_ip" "this" {
  name                = "${var.project_name}-public-ip"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

locals {
  security_rules = {
    ssh = {
      name                   = "SSH"
      priority               = 100
      destination_port_range = 22
    }
    http = {
      name                   = "HTTP"
      priority               = 200
      destination_port_range = 80
    }
    https = {
      name                   = "HTTPS"
      priority               = 300
      destination_port_range = 443
    }
  }
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "this" {
  name                = "${var.project_name}-network-sg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "rules" {
  for_each = local.security_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name         = azurerm_resource_group.this.name
}

resource "azurerm_network_interface" "this" {
  name                = "${var.project_name}-vm-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.project_name}-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  # Cloud-init script
  custom_data = filebase64("./cloud-init.yml")

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_file_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.this.ip_address
}
