terraform {
  required_version = ">= 1.0.0"
  required_providers {
    b2 = {
      source = "Backblaze/b2"
      version = "0.10.0"
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
