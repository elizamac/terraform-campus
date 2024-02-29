resource "docker_image" "wud" {
  name = "fmartinou/whats-up-docker:latest"
}

resource "docker_container" "watchtower" {
  name = "whats-up-docker"
  image = docker_image.wud.image_id
  hostname = "wud"
  restart = "always"

  mounts {
    type = "bind"
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
  }

  ports {
    internal = "3000"
    external = "8100"
    protocol = "tcp"
  }
}