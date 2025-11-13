variable "server_image_name" {
  description = "Server Docker image name"
  type        = string
  default     = "ebilety-server:latest"
}

variable "server_build_context" {
  description = "Server Dockerfile build context path"
  type        = string
  default     = "../../../server/eBilety API"
}

variable "server_dockerfile" {
  description = "Server Dockerfile path"
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
  default     = "../../../client"
}

variable "client_dockerfile" {
  description = "Client Dockerfile path"
  type        = string
  default     = "Dockerfile"
}
