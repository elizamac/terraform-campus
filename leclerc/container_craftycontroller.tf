resource "docker_image" "crafty" {
  name = "arcadiatechnology/crafty-4:latest"
}

resource "docker_network" "crafty-macvlan" {
  name       = "crafty-macvlan"
  attachable = true
  driver     = "macvlan"
  ipam_config {
    subnet   = "10.94.117.0/24"
    gateway  = "10.94.117.1"
    ip_range = "10.94.117.34/32"
  }
  options = ["parent=vmbr1"]
}

resource "docker_container" "crafty" {
  name     = "crafty-controller"
  image    = docker_image.crafty.image_id
  hostname = "crafty"
  restart  = "always"

  env = [ "TZ=Europe/Dublin" ]

  networks_advanced {
    name = docker_network.crafty-macvlan.id
  }

  mounts {
    type = "bind"
    target = "/crafty"
    source = "/opt/crafty"
  }

  ports {
    internal = "8000"
    external = "9000"
    protocol = "tcp"
  }
  ports {
    internal = "8443"
    external = "9443"
    protocol = "tcp"
  }
  ports {
    internal = "8123"
    external = "9123"
    protocol = "tcp"
  }
  ports {
    internal = "19132"
    external = "19132"
    protocol = "udp"
  }

  dynamic "ports" {
    for_each = range(25500, 25600)
    content {
      internal = ports.value
      external = ports.value
      protocol = "tcp"
    }
  }
}
