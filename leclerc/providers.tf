terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

variable "cf_api_token" {
  type = string
  sensitive = true
  default = ""
}
provider "cloudflare" {
  api_token = var.cf_api_token
}
