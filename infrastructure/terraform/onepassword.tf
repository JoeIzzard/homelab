data "onepassword_vault" "homelab" {
  name = "Homelab"
}

data "onepassword_item" "homelab_ssh_key" {
  vault = data.onepassword_vault.homelab.uuid
  title = "Homelab SSH Key"
}

locals {
  homelab_ssh_key_public = data.onepassword_item.homelab_ssh_key.public_key
}
