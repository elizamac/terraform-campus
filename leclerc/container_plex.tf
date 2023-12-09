resource "docker_image" "plex" {
  name = "plex"
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

  env = ["PUID=1000", "PGID=1000", "TZ=Europe/Dublin", "VERSION=docker", "PLEX_CLAIM=${var.plex_claim}"]

  networks_advanced {
    name = docker_network.proxy.id
  }

  mounts {
    type   = "volume"
    target = "/config"
  }

  mounts {
    type   = "bind"
    target = "/mnt/media"
    source = "/mnt/media"
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


