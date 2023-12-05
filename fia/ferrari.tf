variable "fia_node_name" {
  type = string
}

variable "master_password" {
  type = string
  sensitive = true
}

variable "fia_eth" {
  type = string
}

variable "ferrari_ip" {
  type = string
}

resource "proxmox_lxc" "ferrari" {
  target_node = var.fia_node_name
  hostname = proxmox_lxc.name
  ostemplate = "local:vztmpl/..."
  password = var.master_password
  unprivileged = false
  vmid = 301

  features {
    nesting = true
    mount = "nfs"
  }

  rootfs {
    storage = "local-lvm"
    size = "16G"
  }

  network {
    # Name of the network interface inside the container
    name = "eth0"
    bridge = var.fia_vmbr
    ip = var.ferrari_ip
  }
}