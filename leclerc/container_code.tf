resource "docker_image" "vscode" {
  name = "custom-code-server"
  build {
    context = "custom-code-server"
    tag = ["custom-code-server:4.22.0-1.6.0"]
  }
}

resource "docker_container" "code-server" {
  name = "code-server"
  image = docker_image.vscode.image_id
  hostname = "code"
  restart = "always"
    
  labels {
    label = "wud.watch"
    value = "true"
  }

  labels {
    label = "wud.display.name"
    value = "VSCode"
  }

  mounts {
    type = "bind"
    source = "/mnt/docker-data/code-server/config"
    target = "/config"
  }

  mounts {
    type = "bind"
    source = "/mnt/docker-data/code-server/data"
    target = "/data"
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
