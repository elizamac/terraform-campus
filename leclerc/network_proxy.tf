resource "docker_network" "proxy" {
  name            = "proxy"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"

  ipam_config {
    gateway  = "172.16.0.1"
    subnet   = "172.16.0.0/24"
    ip_range = "172.16.0.0/24"
  }
}
