resource "docker_image" "traefik" {
  name = "traefik:v3.0"
}

resource "docker_container" "reverse-proxy" {
  name = "reverse-proxy"
  image = docker_image.traefik.image_id
  hostname = "proxy"
  restart = "always"
}