resource "docker_network" "pt-backend" {
  name            = "pt-backend"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"

  ipam_config {
    gateway  = "172.19.0.1"
    ip_range = "172.19.0.0/24"
    subnet   = "172.19.0.0/24"
  }
}

resource "docker_network" "pt-wings" {
  name            = "pt-wings"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"

  ipam_config {
    gateway  = "172.19.77.1"
    ip_range = "172.19.77.0/24"
    subnet   = "172.19.77.0/24"
  }
}
