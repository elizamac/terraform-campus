resource "docker_image" "jellyfin" {
  name = "jellyfin/jellyfin"
}

resource "docker_container" "jellyfin" {
  name     = "jellyfin"
  hostname = "jellyfin"
  image    = docker_image.jellyfin.image_id
  restart  = "always"

  networks_advanced {
    name = docker_network.proxy.id
  }

  ports {
    internal = "8096"
    external = "8096"
    protocol = "tcp"
  }

  mounts {
    type   = "volume"
    target = "/config"
  }

  mounts {
    type   = "volume"
    target = "/cache"
  }

  mounts {
    type   = "bind"
    target = "/media"
    source = "/mnt/media"
  }
}
