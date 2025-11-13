variable "network_name" {
  description = "Docker network name"
  type        = string
  default     = "ebilety_network"
}

variable "db_container_name" {
  description = "Database container name"
  type        = string
  default     = "ebilety-db"
}

variable "db_image" {
  description = "Database Docker image"
  type        = string
  default     = "mcr.microsoft.com/mssql/server:2022-latest"
}

variable "db_password" {
  description = "SQL Server SA password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database external port"
  type        = number
  default     = 1433
}

variable "server_container_name" {
  description = "Server container name"
  type        = string
  default     = "ebilety-server"
}

variable "server_image_id" {
  description = "Server Docker image ID"
  type        = string
}

variable "server_port_http" {
  description = "Server external HTTP port"
  type        = number
  default     = 8080
}

variable "server_port_debug" {
  description = "Server external debug port"
  type        = number
  default     = 7180
}

variable "environment" {
  description = "Environment (Development, Staging, Production)"
  type        = string
  default     = "Development"
}

variable "client_container_name" {
  description = "Client container name"
  type        = string
  default     = "ebilety-client"
}

variable "client_image_id" {
  description = "Client Docker image ID"
  type        = string
}

variable "client_port" {
  description = "Client external port"
  type        = number
  default     = 80
}
