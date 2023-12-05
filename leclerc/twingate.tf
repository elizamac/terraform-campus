resource "docker_image" "twingate" {
  name = "twingate/connector:1"
}

resource "docker_container" "tfc-connector" {
  name = "tfc-connector"
  image = docker_image.twingate.image_id
  hostname = "tfc-connector"

  network_mode = "host"
  restart = "always"
  env = ["TWINGATE_NETWORK=elizamac", "TWINGATE_LABEL_HOSTNAME=`hostname`", "TWINGATE_ACCESS_TOKEN=${var.tfc_access_token}", "TWINGATE_REFRESH_TOKEN=${var.tfc_refresh_token}"]
}