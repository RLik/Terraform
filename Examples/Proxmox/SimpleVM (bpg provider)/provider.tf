terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.10.10.52:8006/"
  username = "root@pam"
  password = "Qwerty123#"
  insecure = true
  ssh {
    agent = true
  #   node {
  #     address = "10.10.10.52"
  #     name = "px02"
  #   }
  }
}