#terraform {
#  required_providers {
#    docker = {
#      source = "kreuzwerker/docker"
#      version = "3.0.2"
#    }
#  }
#}
#
#provider "docker" {
#  host     = "ssh://remote@lando.elizamac.lan:22"
#  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
#}