terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

variable "fia_api_url" {
  type    = string
  default = ""
}

variable "fia_api_token_id" {
  type    = string
  default = ""
}

variable "fia_api_token_secret" {
  type      = string
  sensitive = true
  default   = ""
}

provider "proxmox" {
  pm_api_url          = var.fia_api_url
  pm_api_token_id     = var.fia_api_token_id
  pm_api_token_secret = var.fia_api_token_secret
  pm_tls_insecure     = true
}