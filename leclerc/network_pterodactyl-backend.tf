resource "docker_network" "pt-backend" {
  name = "pt-backend"
  attachable = true
  check_duplicate = true
  driver = "bridge"

  ipam_config {
    gateway = "172.16.45.0/24"
    subnet = "172.16.45.0/24"
    ip_range = "172.16.45.0/24"
  }
}