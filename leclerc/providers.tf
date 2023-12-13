terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    linux = {
      source  = "mavidser/linux"
      version = "1.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}