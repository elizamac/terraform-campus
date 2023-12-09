data "docker_network" "proxy" {
  name = "proxy"
}

resource "docker_image" "nginx-reverse-proxy" {
  name = "jc21/nginx-proxy-manager:2.10.4"
}

resource "docker_container" "reverse-proxy" {
  name     = "reverse-proxy"
  image    = docker_image.nginx-reverse-proxy.image_id
  hostname = "proxy-manager"
  restart  = "always"

  networks_advanced {
    name = data.docker_network.proxy.id
  }

  ports {
    internal = "80"
    external = "80"
    protocol = "tcp"
  }

  ports {
    internal = "443"
    external = "443"
    protocol = "tcp"
  }

  ports {
    internal = "81"
    external = "81"
    protocol = "tcp"
  }

  mounts {
    target = "/data"
    type   = "bind"
    source = "/mnt/data/docker/nginx-proxy-manager/data"
  }
  mounts {
    target = "/etc/letsencrypt"
    type   = "bind"
    source = "/mnt/data/docker/nginx-proxy-manager/letsencrypt"
  }
}
