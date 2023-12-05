terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    /*
    tfe = {
      source = "hashicorp/tfe"
      version = "0.50.0"
    }
    */
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

//provider "tfe" {}