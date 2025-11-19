output "db_container_id" {
  description = "Database container ID"
  value       = docker_container.db.id
}

output "db_network_ip" {
  description = "Database container network IP"
  value       = try(docker_container.db.network_data[0].ip_address, "")
}

output "server_container_id" {
  description = "Server container ID"
  value       = docker_container.server.id
}

output "server_url" {
  description = "Server access URL"
  value       = "http://localhost:${var.server_port_http}"
}

output "client_container_id" {
  description = "Client container ID"
  value       = docker_container.client.id
}

output "client_url" {
  description = "Client access URL"
  value       = "http://localhost:${var.client_port}"
}
