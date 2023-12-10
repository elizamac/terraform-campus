resource "docker_image" "wing" {
  name = "ghcr.io/pterodactyl/wings:v1.11.8"
}

resource "docker_container" "wing0" {
  name     = "wing0"
  image    = docker_image.wing.image_id
  hostname = "wing0"
  restart  = "always"
  tty      = true

  networks_advanced {
    name = docker_network.pt-backend.id
  }

  env = [
    "TZ=Europe/Dublin",
    "WINGS_UID=988",
    "WINGS_GID=988",
    "WINGS_USERNAME=pterodactyl"
  ]

  mounts {
    type   = "bind"
    target = "/var/run/docker.sock"
    source = "/var/run/docker.sock"
  }

  mounts {
    type   = "bind"
    target = "/var/lib/docker/containers/"
    source = "/var/lib/docker/containers/"
  }

  mounts {
    type   = "bind"
    target = "/etc/pterodactyl/"
    source = "/etc/pterodactyl/"
  }
  mounts {
    type   = "bind"
    target = "/var/lib/pterodactyl/"
    source = "/var/lib/pterodactyl/"
  }
  mounts {
    type   = "bind"
    target = "/var/log/pterodactyl/"
    source = "/var/log/pterodactyl/"
  }
  mounts {
    type   = "bind"
    target = "/tmp/pterodactyl/"
    source = "/tmp/pterodactyl/"
  }
  mounts {
    type   = "bind"
    target = "/etc/ssl/certs:ro"
    source = "/etc/ssl/certs"
  }
}
