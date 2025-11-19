variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ebilety"
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "West Europe"
}

variable "app_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the application subnet"
  default     = ["10.0.1.0/24"]
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "ssh_file_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
