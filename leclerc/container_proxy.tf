resource "docker_image" "traefik" {
  name = "traefik:v3.0"
}

resource "docker_container" "reverse-proxy" {
  name = "reverse-proxy"
  image = docker_image.traefik.image_id
  hostname = "proxy"
  restart = "always"

  networks_advanced {
    name = "proxy"
    ipv4_address = "172.16.38.50"
  }

  mounts {
    source = "/var/run/docker.sock"
    target = "/var/run/docker.sock"
    type = "bind"
  }

  mounts {
    source = "/mnt/docker-data/traefik"
    target = "/etc/traefik"
    type = "bind"
  }

  upload {
    content = <<-EOT
      api:
        dashboard: true

      entryPoints:
        http-ext:
          address: ":80"
          http:
            redirections:
              entryPoint:
                to: "https"
                scheme: "https"
              permanent: true
        https-ext:
          address: ":443"
        http-int:
          address: ":81"
          http:
            redirections:
              entryPoint:
                to: "https"
                scheme: "https"
              permanent: true
        https-int:
          address: ":444"

      global:
        sendAnonymousUsage: false
      
      providers:
        docker:
          endpoint: "unix:///var/run/docker.sock"
          exposedByDefault: false
          network: "proxy"
          watch: true
        file:
          directory: "/etc/traefik/dynamic"
          watch: true
    EOT
    file = "/etc/traefik/traefik.yml"
  }
}