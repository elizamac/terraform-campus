resource "docker_image" "twingate" {
  name = "twingate/connector:1"
}

data "tfe_workspace" "leclerc" {
  name = "leclerc"
  organization = "ElizaMacovei"
}

variable "tfc_access_token" {
  type      = string
  sensitive = true
  default = ""
}

variable "tfc_refresh_token" {
  type      = string
  sensitive = true
  default = ""
}

resource "docker_container" "tfc-connector" {
  name     = "tfc-connector"
  image    = docker_image.twingate.image_id
  hostname = "tfc-connector"

  network_mode = "host"
  restart      = "always"
  env          = ["TWINGATE_NETWORK=elizamac", "TWINGATE_LABEL_HOSTNAME=`hostname`", "TWINGATE_ACCESS_TOKEN=${var.tfc_access_token}", "TWINGATE_REFRESH_TOKEN=${var.tfc_refresh_token}"]
}