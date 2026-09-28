terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  count = var.instance_count

  name  = "${var.project_name}-web-${count.index + 1}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.base_port + count.index
  }

  restart = "unless-stopped"

  labels {
    label = "managed_by"
    value = "terraform"
  }

  labels {
    label = "project"
    value = var.project_name
  }
}

output "container_names" {
  description = "Names of the provisioned web containers."
  value       = docker_container.web[*].name
}

output "web_urls" {
  description = "Local URLs for the provisioned web containers."
  value = [
    for i in range(var.instance_count) :
    "http://localhost:${var.base_port + i}"
  ]
}
