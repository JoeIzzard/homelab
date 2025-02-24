variable "k8_node_name" {
  type = string
  description = "The name of the Kubernetes node to create"
}

variable "k8_cluster_name" {
  type = string
  description = "The name of the Kubernetes cluster the node will be part of"
}

variable "pve_id" {
  type = number
  description = "The Proxmox VM ID to assign to the Kubernetes node"
}

variable "clone_template_id" {
  type = number
  description = "The Proxmox VM ID to clone from"
}

variable "full_clone" {
  type = bool
  description = "Whether to clone the full VM or just the disk"
}

variable "target_node" {
  type = string
  description = "The name of the Proxmox node to assign the VM to"
}

variable "agent_enabled" {
  type = bool
  description = "Whether to enable the Proxmox Agent on the VM"
  default = false
}

variable "cpu_cores" {
  type = number
  description = "The number of CPU cores to assign to the VM"
  default = 4
}

variable "memory_size" {
  type = number
  description = "The amount of memory to assign to the VM"
  default = 8192
}

variable "autostart" {
  type = bool
  description = "Whether to autostart the VM on system boot"
  default = false
}

variable "boot_disk_size" {
  type = number
  description = "The size of the boot disk"
  default = 32
}

variable "boot_disk_backup" {
  type = bool
  description = "Whether to backup the boot disk"
  default = true
}

variable "boot_disk_datastore_id" {
  type = string
  description = "The datastore ID to store the boot disk on"
  default = "local-lvm"
}

variable "data_disk_size" {
  type = number
  description = "The size of the data disk"
  default = 256
}

variable "data_disk_backup" {
  type = bool
  description = "Whether to backup the data disk"
  default = true
}

variable "data_disk_datastore_id" {
  type = string
  description = "The datastore ID to store the data disk on"
  default = "local-lvm"
}

variable "network_bridge" {
  type = string
  description = "The bridge to assign to the VM"
  default = "vmbr0"
}

variable "cloud_init_datastore_id" {
  type = string
  description = "The datastore ID to store the cloud-init disk on"
  default = "local-lvm"
}

variable "ip_address" {
  type = string
  description = "The IP address to assign to the VM"
}

variable "gateway" {
  type = string
  description = "The gateway to assign to the VM"
}

variable "user_name" {
  type = string
  description = "The username to assign to the VM"
}

variable "user_password" {
  type = string
  description = "The password to assign to the VM"
  sensitive = true
}

variable "ssh_key" {
  type = string
  description = "The SSH key to assign to the VM"
}
