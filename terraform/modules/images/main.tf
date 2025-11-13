terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "server" {
  name = var.server_image_name

  build {
    context    = var.server_build_context
    dockerfile = var.server_dockerfile
  }
}

resource "docker_image" "client" {
  name = var.client_image_name

  build {
    context    = var.client_build_context
    dockerfile = var.client_dockerfile
  }

  depends_on = [docker_image.server]
}
