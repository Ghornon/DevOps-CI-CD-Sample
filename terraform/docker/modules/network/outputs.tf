output "network_id" {
  description = "Docker network ID"
  value       = docker_network.main.id
}

output "network_name" {
  description = "Docker network name"
  value       = docker_network.main.name
}
