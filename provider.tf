terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

# provider "hcp" {

# }
provider "vault" {
  address   = var.vault_hostname
  token     = var.admin_token
  namespace = "admin"
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
  project_id    = var.hcp_project_id
}

provider "aws" {
  region     = var.dest_region
  access_key = var.dest_Access_key
  secret_key = var.dest_Secret_key
}