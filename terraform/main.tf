terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

module "network" {
  source = "./modules/network"

  network_name = var.network_name
}

module "images" {
  source = "./modules/images"

  server_image_name    = var.server_image_name
  server_build_context = var.server_build_context
  server_dockerfile    = var.server_dockerfile

  client_image_name    = var.client_image_name
  client_build_context = var.client_build_context
  client_dockerfile    = var.client_dockerfile
}

module "containers" {
  source = "./modules/containers"

  network_name = module.network.network_name

  # Database
  db_container_name = var.db_container_name
  db_image          = var.db_image
  db_password       = var.db_password
  db_port           = var.db_port

  # Server
  server_container_name = var.server_container_name
  server_image_id       = module.images.server_image_id
  server_port_http      = var.server_port_http
  server_port_debug     = var.server_port_debug
  environment           = var.environment

  # Client
  client_container_name = var.client_container_name
  client_image_id       = module.images.client_image_id
  client_port           = var.client_port
}
