terraform {
  required_version = ">= 1.0.0"
  required_providers {
    b2 = {
      source = "Backblaze/b2"
      version = "0.10.0"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = "2.1.2"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.1"
    }
  }

  backend "s3" {
    bucket = "nebula-tf-backend"
    key = "homelab.tfstate"
    region = "eu-central-003"
    endpoint = "s3.eu-central-003.backblazeb2.com"

    skip_requesting_account_id = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    skip_s3_checksum = true

  }
}

// -------------------------------------------------------------------------------------------------
// OnePassword
// -------------------------------------------------------------------------------------------------
provider "onepassword" {
  // No need to authenticate, we use the OP_SERVICE_ACCOUNT_TOKEN environment variable
}

// -------------------------------------------------------------------------------------------------
// Proxmox
// -------------------------------------------------------------------------------------------------

data "onepassword_item" "pve_credentials" {
  vault = data.onepassword_vault.homelab.uuid
  title = "Proxmox Terraform"
}

locals {
  pve_endpoint = data.onepassword_item.pve_credentials.hostname
  pve_insecure = data.onepassword_item.pve_credentials.section[index(data.onepassword_item.pve_credentials.section.*.label, "connection")].field[index(data.onepassword_item.pve_credentials.section[index(data.onepassword_item.pve_credentials.section.*.label, "connection")].field.*.label, "insecure")].value
  pve_token = format("%s=%s", data.onepassword_item.pve_credentials.username, data.onepassword_item.pve_credentials.credential)
  pve_ssh_username = data.onepassword_item.pve_credentials.section[index(data.onepassword_item.pve_credentials.section.*.label, "connection")].field[index(data.onepassword_item.pve_credentials.section[index(data.onepassword_item.pve_credentials.section.*.label, "connection")].field.*.label, "ssh_username")].value
}

provider "proxmox" {
    endpoint = local.pve_endpoint
    insecure = local.pve_insecure
    api_token = local.pve_token
    ssh {
      username = local.pve_ssh_username
      password = data.onepassword_item.pve_credentials.password
    }
}