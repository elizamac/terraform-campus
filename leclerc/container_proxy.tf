resource "docker_image" "traefik" {
  name = "traefik:v3.0"
}

variable "domain" {
  type    = string
  default = "elizamac.eu"
}

resource "docker_container" "reverse-proxy" {
  name     = "reverse-proxy"
  image    = docker_image.traefik.image_id
  hostname = "proxy"
  restart  = "always"

  networks_advanced {
    name         = "proxy"
    ipv4_address = "172.16.38.50"
  }

  dynamic "ports" {
    for_each = {
      http-int = {
        internal = 80
        external = 80
        protocol = "tcp"
      }
      https-int = {
        internal = 81
        external = 81
        protocol = "tcp"
      }
      http-ext = {
        internal = 443
        external = 443
        protocol = "tcp"
      }
      https-ext = {
        internal = 444
        external = 444
        protocol = "tcp"
      }
    }

    content {
      internal = ports.value.internal
      external = ports.value.external
      protocol = ports.value.protocol
    }
  }


  mounts {
    source = "/var/run/docker.sock"
    target = "/var/run/docker.sock"
    type   = "bind"
  }

  mounts {
    source = "/mnt/docker-data/traefik/certs"
    target = "/etc/traefik/certs"
    type   = "bind"
  }

  dynamic "labels" {
    for_each = {
      "traefik.enable"                           = "true"
      "traefik.http.routers.traefik.rule"        = "Host(`traefik-ie.${var.domain}`)"
      "traefik.http.routers.traefik.entrypoints" = "http-int, https-int"
      "traefik.http.routers.traefik.service"     = "api@internal"
    }

    content {
      label = labels.key
      value = labels.value
    }
  }



  # Create traefik static config
  upload {
    file    = "/etc/traefik/traefik.yml"
    content = <<-EOT
      api:
        dashboard: true

      entryPoints:
        http-int:
          address: ":80"
          http:
            redirections:
              entryPoint:
                to: "https-int"
                scheme: "https"
                permanent: true
        https-int:
          address: ":443"
        http-ext:
          address: ":81"
          http:
            redirections:
              entryPoint:
                to: "https-ext"
                scheme: "https"
                permanent: true
        https-ext:
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
  }

  # Cloudflare certs configuration
  upload {
    file    = "/etc/traefik/dynamic/cloudflare-certs.yml"
    content = <<-EOT
      tls:
        certificates:
          - certFile: "/etc/traefik/certs/elizamac.eu.crt"
            keyFile: "/etc/traefik/certs/elizamac.eu.key"
    EOT
  }
}
