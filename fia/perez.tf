variable "fia_node_name" {
  type    = string
  default = ""
}

resource "proxmox_lxc" "perez" {
  target_node = var.fia_node_name
  hostname    = "perez"
  vmid = 202
  clone       = 921
  full = true

  onboot = true
  start = true
  
  mountpoint {
    key = "1"
    slot = 1
    storage = "/mnt/data"
    volume = "/mnt/data"
    mp = "/mnt/data"
  }

  network {
    name = "eth0"
    bridge = "vmbr1"
    firewall = false
    ip = "10.94.117.21/24"
    gw = "10.94.117.1"
    ip6 = "auto"
  }
}
