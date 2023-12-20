resource "docker_image" "radarr" {
  name = "lscr.io/linuxserver/radarr:latest"
}

resource "docker_container" "radarr" {
  name     = "radarr"
  image    = docker_image.radarr.image_id
  hostname = "radarr"
  restart  = "always"

  networks_advanced {
    name = docker_network.proxy.id
  }

  ports {
    internal = "7878"
    external = "7878"
    protocol = "tcp"
  }

  env = [ "PUID=1000", "PGID=1000", "TZ=Europe/Dublin" ]

  
}
