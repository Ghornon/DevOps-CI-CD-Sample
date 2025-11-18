variable "project_name" {
  description = "Project name"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
}

variable "app_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the application subnet"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "ssh_file_path" {
  description = "Path to the SSH public key file"
  type        = string
}
