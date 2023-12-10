resource "docker_image" "homarr" {
  name = "ghcr.io/ajnart/homarr:0.14.2"
}

resource "docker_container" "homarr" {
  name = "homarr"
  image = docker_image.homarr.image_id
  hostname = "homarr"
  restart = "always"

  networks_advanced {
    name = docker_network.proxy.id
  }

  ports {
    internal = "7575"
    external = "80"
    protocol = "tcp"
  }

  mounts {
    type = "volume"
    target = "/app"
  }

  mounts {
    type = "volume"
    target = "/data"
  }

  mounts {
    type = "bind"
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
    read_only = true
  }
}