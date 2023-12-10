resource "docker_network" "pt-backend" {
  name            = "pt-backend"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"
}

resource "docker_network" "pt-wings" {
  name            = "pt-wings"
  attachable      = true
  check_duplicate = true
  driver          = "bridge"
}
