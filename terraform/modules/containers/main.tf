terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_container" "db" {
  name  = var.db_container_name
  image = var.db_image

  ports {
    internal = 1433
    external = var.db_port
  }

  env = [
    "SA_PASSWORD=${var.db_password}",
    "ACCEPT_EULA=Y"
  ]

  networks_advanced {
    name = var.network_name
  }
}

resource "docker_container" "server" {
  name  = var.server_container_name
  image = var.server_image_id

  ports {
    internal = 80
    external = var.server_port_http
  }

  ports {
    internal = 7180
    external = var.server_port_debug
  }

  env = [
    "ASPNETCORE_ENVIRONMENT=${var.environment}",
    "ConnectionStrings__DevConnection=Server=${var.db_container_name};Database=master;User=sa;Password=${var.db_password};TrustServerCertificate=True;"
  ]

  networks_advanced {
    name = var.network_name
  }

  depends_on = [docker_container.db]
}

resource "docker_container" "client" {
  name  = var.client_container_name
  image = var.client_image_id

  ports {
    internal = 80
    external = var.client_port
  }

  networks_advanced {
    name = var.network_name
  }

  depends_on = [docker_container.server]
}
