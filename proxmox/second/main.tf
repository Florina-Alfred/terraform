terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.0.103:8006/api2/json"
  pm_api_token_id     = "terraform_user@pam!terraform_user_id"
  pm_api_token_secret = "911dfc49-bc48-4e09-af5c-a204b9fef52c"
  pm_tls_insecure     = true
}


resource "proxmox_vm_qemu" "terrafor_test_server" {
  count = 2
  name  = "terra-vm-50${count.index + 1}"
  vmid  = "50${count.index + 1}"

  target_node = var.proxmox_host

  # another variable with contents "ubuntu-2004-cloudinit-template"
  clone = var.template_name
  #iso = "local:iso/ubuntu-22.04.3-desktop-amd64.iso"

  agent   = 1
  os_type = "cloud-init"
  #os_type = "ubuntu"
  cores    = 2
  sockets  = 1
  cpu      = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot    = 0
    size    = "30G"
    type    = "scsi"
    storage = "local-zfs"
    # iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }


  ipconfig0 = "ip=192.168.0.9${count.index + 1}/24,gw=192.168.0.1"

  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
