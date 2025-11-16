variable "docker_host" {
  description = "Docker host socket or URL"
  type        = string
  default     = "unix:///var/run/docker.sock"
}

# Network
variable "network_name" {
  description = "Docker network name"
  type        = string
  default     = "ebilety_network"
}

# Images
variable "server_image_name" {
  description = "Server Docker image name"
  type        = string
  default     = "ebilety-server:latest"
}

variable "server_build_context" {
  description = "Server Dockerfile build context path"
  type        = string
  default     = "../server/eBilety API"
}

variable "server_dockerfile" {
  description = "Server Dockerfile name"
  type        = string
  default     = "Dockerfile"
}

variable "client_image_name" {
  description = "Client Docker image name"
  type        = string
  default     = "ebilety-client:latest"
}

variable "client_build_context" {
  description = "Client Dockerfile build context path"
  type        = string
  default     = "../client"
}

variable "client_dockerfile" {
  description = "Client Dockerfile name"
  type        = string
  default     = "Dockerfile"
}

# Containers - Database
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

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "Database password must be at least 8 characters long."
  }
}

variable "db_port" {
  description = "Database external port"
  type        = number
  default     = 1433
}

# Containers - Server
variable "server_container_name" {
  description = "Server container name"
  type        = string
  default     = "ebilety-server"
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

# Containers - Client
variable "client_container_name" {
  description = "Client container name"
  type        = string
  default     = "ebilety-client"
}

variable "client_port" {
  description = "Client external port"
  type        = number
  default     = 80
}
