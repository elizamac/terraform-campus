resource "docker_image" "port-agent" {
  name = "portainer/agent:2.19.4"
}

resource "docker_container" "portainer-agent" {
  name = "portainer-agent"
  image = docker_image.port-agent.image_id
  hostname = "portainer"
  restart = "always"

  mounts {
    type = "bind"
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
  }

  mounts {
    type = "bind"
    target = "/var/lib/docker/volumes"
    source = "/var/lib/docker/volumes"
  }

  ports {
    internal = "9001"
    external = "9001"
    protocol = "tcp"
  }
}