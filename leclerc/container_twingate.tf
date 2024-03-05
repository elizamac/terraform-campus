resource "docker_image" "twingate" {
  name = "twingate/connector:1.63.0"
}

variable "twingate_access_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "twingate_refresh_token" {
  type      = string
  sensitive = true
  default   = ""
}

resource "docker_container" "twingate-connector" {
  name     = "twingate-connector"
  image    = docker_image.twingate.image_id
  hostname = "twingate-connector"

  network_mode = "host"
  restart      = "always"
  env          = ["TWINGATE_NETWORK=elizamac", "TWINGATE_LABEL_HOSTNAME=lando-connector", "TWINGATE_ACCESS_TOKEN=${var.twingate_access_token}", "TWINGATE_REFRESH_TOKEN=${var.twingate_refresh_token}"]

}
