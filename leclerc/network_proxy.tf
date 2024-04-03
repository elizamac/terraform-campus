resource "docker_network" "proxy" {
  name            = "proxy"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"

  ipam_config {
    gateway  = "172.16.38.1"
    subnet   = "172.16.38.0/25"
    # ip range 172.16.38.1 - 172.16.38.127  
    ip_range = "172.16.38.0/25"
  }
}
