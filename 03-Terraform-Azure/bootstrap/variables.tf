variable "project_name" {
  description = "Project name / Azure resource group name"
  type        = string
  default     = "devops-sample-project"
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "West Europe"
}
