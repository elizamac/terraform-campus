resource "docker_image" "homarr" {
  name = "ghcr.io/ajnart/homarr:0.15.0"
}

resource "docker_container" "homarr" {
  name     = "homarr"
  image    = docker_image.homarr.image_id
  hostname = "homarr"
  restart  = "always"

  networks_advanced {
    name = docker_network.proxy.id
  }

  ports {
    internal = "7575"
    external = "8210"
    protocol = "tcp"
  }

  mounts {
    type   = "bind"
    target = "/app/data/configs"
    source = "/mnt/docker-data/homarr/configs"
  }

  mounts {
    type   = "bind"
    target = "/data"
    source = "/mnt/docker-data/homarr/data"
  }

  mounts {
    type      = "bind"
    target    = "/var/run/docker.sock"
    source    = "/var/run/docker.sock"
    read_only = true
  }
}
