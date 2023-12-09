module "docker" {
  source = "./leclerc"
}

module "proxmox" {
  source = "./fia"
}