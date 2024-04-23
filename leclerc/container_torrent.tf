resource "docker_image" "torrent" {
  name = "linuxserver/transmission:4.0.5"
}

variable "torrent_pass" {
  type      = string
  sensitive = true
  default   = ""
}

resource "docker_container" "transmission" {
  name     = "transmission"
  image    = docker_image.torrent.image_id
  hostname = transmission
  restart  = always

  labels {
    label = "wud.wathc"
    value = "true"
  }

  labels {
    label = "wud.display.name"
    value = "Transmission"
  }

  labels {
    label = "wud.display.icon"
    value = "mdi:file-arrow-up-down-outline"
  }

  labels {
    label = "wud.tag.include"
    value = "^\\d+\\.\\d+\\.\\d+$"
  }

  mounts {
    type   = "bind"
    target = "/config"
    source = "/mnt/docker-data/transmission/config"
  }

  mounts {
    type   = "bind"
    target = "/downloads"
    source = "/mnt/docker-data/transmission/downloads"
  }

  ports {
    internal = "9091"
    external = "9091"
    protocol = "tcp"
  }

  ports {
    internal = "51413"
    external = "51413"
    protocol = "tcp"
  }

  ports {
    internal = "51413"
    external = "51413"
    protocol = "udp"
  }

  env = [
    "TZ=Europe/UTC",
    "PUID=1000",
    "PGID=1000",
    "USER=eliza",
    "PASS=${var.torrent_pass}"
  ]
}
