variable "fia_node_name" {
  type = string
}

variable "mercedes_ip" {
  type = string
}

resource "proxmox_vm_qemu" "mercedes" {
  name = var.proxmox_vm_qemu.mercedes.name
  target_node = var.fia_node_name
  iso = "local:..." #!
  vmid = 101

  ## Behaviour
  onboot = true
  oncreate = true

  # VM specs
  memory = 1024
  cores = 1
  cpu = "kvm64"
  tags = "networking"
  ipconfig0 = "gw=...,ip=10.10.0.1" #!

  # Networking
  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }

  # Storage
  disk {
    type = "scsi"
    size = "16G"
  }
}