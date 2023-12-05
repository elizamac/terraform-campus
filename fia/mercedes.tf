variable "fia_node_name" {
  type = string
}

variable "mercedes_ip" {
  type = string
}

resource "proxmox_vm_qemu" "mercedes" {
  name = var.proxmox_vm_qemu.mercedes.name
  target_node = var.fia_node_name
  iso = "local:..."
}