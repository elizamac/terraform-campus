data "docker_registry_image" "plex" {
  name = "plexinc/pms-docker:latest"
}

resource "docker_image" "plex" {
  name = data.docker_registry_image.plex.name
  pull_triggers = [data.docker_registry_image.plex.sha256_digest]
}

variable "plex_claim" {
  type      = string
  sensitive = true
  default   = ""
}

variable "ports_list" {
  type = list(object({
    port     = string
    protocol = string
  }))

  default = [{
    port     = "32400"
    protocol = "tcp"
    }, {
    port     = "1900"
    protocol = "udp"
    }, {
    port     = "5353"
    protocol = "udp"
    }, {
    port     = "8324"
    protocol = "tcp"
    }, {
    port     = "32410"
    protocol = "udp"
    }, {
    port     = "32412"
    protocol = "udp"
    }, {
    port     = "32413"
    protocol = "udp"
    }, {
    port     = "32414"
    protocol = "udp"
    }, {
    port     = "32469"
    protocol = "tcp"
  }]
}

resource "docker_container" "plex" {
  name     = "plex"
  hostname = "plex"
  image    = docker_image.plex.image_id
  restart  = "always"

  env = ["TZ=Europe/Dublin", "PLEX_CLAIM=${var.plex_claim}"]

  networks_advanced {
    name = docker_network.proxy.id
  }

  mounts {
    type   = "volume"
    target = "/config"
  }

  mounts {
    type   = "bind"
    target = "/data"
    source = "/mnt/media"
  }

  mounts {
    type   = "bind"
    target = "/transcode"
    source = "/mnt/media/transcode"
  }

  dynamic "ports" {
    for_each = var.ports_list
    content {
      internal = ports.value["port"]
      external = ports.value["port"]
      protocol = ports.value["protocol"]
    }
  }
}


