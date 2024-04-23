resource "docker_image" "grocy" {
  name = "linuxserver/grocy:4.2.0"
}

resource "docker_container" "grocy" {
  name     = "grocy"
  image    = docker_image.grocy.image_id
  hostname = "grocy"
  restart  = "always"

  labels {
    label = "wud.watch"
    value = "true"
  }

  labels {
    label = "wud.display.name"
    value = "Grocy"
  }

  labels {
    label = "wud.display.icon"
    value = "mdi:cart"
  }

  labels {
    label = "wud.tag.include"
    value = "^\\d+\\.\\d+\\.\\d+$"
  }

  mounts {
    type   = "bind"
    target = "/config"
    source = "/mnt/docker-data/grocy/config"
  }

  ports {
    internal = "80"
    external = "9238"
    protocol = "tcp"
  }
}
