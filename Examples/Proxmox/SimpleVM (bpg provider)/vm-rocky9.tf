resource "proxmox_virtual_environment_vm" "rocky9" {
    name = "Rocky9"
    vm_id     = 4000
    description = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    node_name = "px02"

    # The destination resource pool for the new VM

    # The template name to clone this vm from
    clone {
      # ID of VM with "Rocky9-Template"
      vm_id = 2000
      node_name = "px02"
    }

    # Activate QEMU agent for this VM
    agent {
      enabled = true
    }

    cpu {
      cores = 2
      sockets = 2
      type = "host"
    }

    memory {
      dedicated = 2048
    }

    scsi_hardware = "virtio-scsi-single"

    disk {
        datastore_id = var.storage_name
        interface    = "virtio0"
        iothread     = true
        discard      = "on"
        size         = 10
    }

    boot_order = ["virtio0"]

    network_device {
      bridge = "vmbr0"
      model = "virtio"
    } 
    

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    initialization {

        ip_config {
            ipv4 {
                address = "dhcp"
            }
        }

        dns {
          servers = [ "8.8.8.8" ]
        }

        user_account {
            username = "roman"
            password = "Qwerty123"
        }
    }

}