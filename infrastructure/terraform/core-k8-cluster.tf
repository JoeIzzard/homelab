data "onepassword_item" "k8_core_credentials" {
  vault = data.onepassword_vault.homelab.uuid
  title = "K8 Core Admin"
}

module "k8_core_nodes" {
  source = "./modules/k8_mixed_node"
  count = 3

  k8_node_name = "k8-core-${count.index + 1}"
  k8_cluster_name = "core-services"
  pve_id = 101 + count.index
  autostart = true

  clone_template_id = 8000
  full_clone = true
  target_node = "nn-ms01-01"
  agent_enabled = true

  cpu_cores = 4
  memory_size = 8192

  boot_disk_size = 32
  boot_disk_datastore_id = "nvme11"
  boot_disk_backup = true

  data_disk_size = 256
  data_disk_datastore_id = "nvme11"
  data_disk_backup = true

  network_bridge = "vmbr0"
  ip_address = "192.168.0.${11 + count.index}/24"
  gateway = "192.168.0.1"

  user_name = data.onepassword_item.k8_core_credentials.username
  user_password = data.onepassword_item.k8_core_credentials.password
  ssh_key = local.homelab_ssh_key_public
}

