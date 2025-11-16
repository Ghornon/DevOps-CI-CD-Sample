output "network_id" {
  description = "Docker network ID"
  value       = module.network.network_id
}

output "db_container_id" {
  description = "Database container ID"
  value       = module.containers.db_container_id
}

output "db_network_ip" {
  description = "Database container network IP"
  value       = module.containers.db_network_ip
}

output "server_container_id" {
  description = "Server container ID"
  value       = module.containers.server_container_id
}

output "server_url" {
  description = "Server access URL"
  value       = module.containers.server_url
}

output "client_container_id" {
  description = "Client container ID"
  value       = module.containers.client_container_id
}

output "client_url" {
  description = "Client access URL"
  value       = module.containers.client_url
}
