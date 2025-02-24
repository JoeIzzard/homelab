resource "proxmox_virtual_environment_vm" "k8_mixed_node" {

  // VM general Settings
  name = var.k8_node_name
  vm_id = var.pve_id
  description = "Kubernetes Mixed Function Node - ${var.k8_cluster_name}"
  tags = ["homelab", "kubernetes", "k8_mixed", var.k8_cluster_name]
  node_name = var.target_node

  // VM Clone Settings
  clone {
    vm_id = var.clone_template_id
    full = var.full_clone
  }

  // Enable to Agent?
  agent {
    enabled = var.agent_enabled
  }

  // Basic VM Settings
  cpu {
    cores = var.cpu_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory_size
    floating = 1024
  }

  on_boot = var.autostart
  operating_system {
    type = "l26"
  }
  scsi_hardware = "virtio-scsi-pci"

  // Boot disk
  disk {
    datastore_id = var.boot_disk_datastore_id
    size = var.boot_disk_size
    file_format = "raw"
    interface = "scsi0"
    backup = var.boot_disk_backup
  }

  // Longhorn Storage disk
  disk {
    datastore_id = var.data_disk_datastore_id
    size = var.data_disk_size
    file_format = "raw"
    interface = "scsi1"
    backup = var.data_disk_backup
  }

  // Network Settings
  network_device {
    bridge = var.network_bridge
    firewall = false
    model = "virtio"
  }

  // Cloud-Init Settings
  initialization {
    datastore_id = var.cloud_init_datastore_id
    interface = "ide2"
    dns {
      servers = ["8.8.8.8", "1.1.1.1"]
    }
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }
    user_account {
      username = var.user_name
      password = var.user_password
      keys = [var.ssh_key]
    }
    vendor_data_file_id = proxmox_virtual_environment_file.data_disk_cloudinit.id
  }
}

resource "proxmox_virtual_environment_file" "data_disk_cloudinit" {
  content_type = "snippets"
  datastore_id = "local"
  node_name = var.target_node
  
  source_raw {
    data = <<-EOF
    #cloud-config

    fs_setup:
      - label: data
        filesystem: ext4
        device: /dev/sdb

    mounts:
      - [/dev/sdb, /data]
    EOF

    file_name = "cloudinit-data-disk.yaml"
  }
}