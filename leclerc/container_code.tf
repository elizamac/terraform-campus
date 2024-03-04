resource "docker_image" "vscode" {
  name = "linuxserver/code-server:4.22.0"
}

resource "docker_container" "code-server" {
  name = "code-server"
  image = docker_image.vscode.image_id
  hostname = "code"
  restart = "always"

  mounts {
    type = "bind"
    source = "/mnt/docker-data/code-server/config"
    target = "/config"
  }

  ports {
    internal = "8443"
    external = "8200"
  }

  env = [
    "PUID=1002",
    "GUID=1002",
    "TZ=Europe/Dublin",
    "SUDO_PASSWORD_HASH=$argon2i$v=19$m=4096,t=3,p=1$5lf2cIzhV6xgWOpsVqXc7g$O/poBBK3NnMh50VgbrPjAOg0HDYVh83yqGyb7rzHRyc"
  ]
}