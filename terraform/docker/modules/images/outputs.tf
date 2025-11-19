output "server_image_id" {
  description = "Server Docker image ID"
  value       = docker_image.server.image_id
}

output "client_image_id" {
  description = "Client Docker image ID"
  value       = docker_image.client.image_id
}

output "server_image_name" {
  description = "Server Docker image name"
  value       = docker_image.server.name
}

output "client_image_name" {
  description = "Client Docker image name"
  value       = docker_image.client.name
}
