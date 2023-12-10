resource "docker_image" "panel" {
  name = "ghcr.io/pterodactyl/panel:v1.9.1"
}

resource "docker_image" "database" {
  name = "mariadb:11.2.2"
}

resource "docker_image" "cache" {
  name = "redis:7.2.3-alpine"
}

variable "db-password" {
  type    = string
  default = "pt!pass"
}

variable "db-root-password" {
  type    = string
  default = "root!pass"
}

resource "docker_container" "database" {
  name     = "pt-database"
  image    = docker_image.database.image_id
  hostname = "database"
  restart  = "always"

  networks_advanced {
    name = docker_network.pt-backend.id
  }

  mounts {
    type   = "volume"
    target = "/var/lib/mysql"
  }

  env = [
    "MYSQL_PASSWORD=${var.db-password}",
    "MYSQL_ROOT_PASSWORD=${var.db-root-password}",
    "MYSQL_DATABASE=panel",
    "MYSQL_USER=pterodactyl"
  ]

  command = [
    "--default-authentication-plugin=mysql_native_password"
  ]
}

resource "docker_container" "cache" {
  name     = "pt-cache"
  image    = docker_image.cache.image_id
  hostname = "cache"
  restart  = "always"

  networks_advanced {
    name = docker_network.pt-backend.id
  }
}

resource "docker_container" "panel" {
  name     = "pt-panel"
  image    = docker_image.panel.image_id
  hostname = "pt-panel"
  restart  = "always"

  networks_advanced {
    name = docker_network.pt-backend.id
  }

  networks_advanced {
    name = docker_network.proxy.id
  }

  ports {
    internal = "80"
    external = "25680"
    protocol = "tcp"
  }

  ports {
    internal = "443"
    external = "25643"
    protocol = "tcp"
  }

  mounts {
    type   = "volume"
    target = "/app/var"
    volume_options {
      labels {
        label = "service"
        value = "pterodactyl"
      }
    }
  }

  mounts {
    type   = "volume"
    target = "/app/storage/logs"
    volume_options {
      labels {
        label = "service"
        value = "pterodactyl"
      }
    }
  }

  mounts {
    type   = "volume"
    target = "/etc/nginx/conf.d"
    volume_options {
      labels {
        label = "service"
        value = "pterodactyl"
      }
    }
  }

  env = [
    #"APP_URL=https://leclerc.elizamac.lan:25643",
    "APP_TIMEZONE=Europe/Dublin",
    "DB_PASSWORD=${var.db-password}",
    "APP_ENV=production",
    "APP_ENVIRONMENT_ONLY=false",
    "CACHE_DRIVER=redis",
    "SESSION_DRIVER=redis",
    "QUEUE_DRIVER=redis",
    "REDIS_HOST=${docker_container.cache.hostname}",
    "DB_HOST=${docker_container.database.hostname}",
    "DB_PORT=3306",
    "TRUSTED_PROXIES=*"
  ]
}
