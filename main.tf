## VAULT
data "vault_auth_backends" "Active_Directory" {
  type = "oidc"
}

resource "vault_namespace" "child_namespace" {
  path = var.namespace_path
}

resource "vault_identity_entity" "namespace_admin" {
  name     = var.entity_name
  policies = ["${vault_policy.namespace_admin_policy.name}"]
  # metadata  = {
  #   foo = "bar"
  # }
  external_policies = true

}

resource "vault_identity_entity_policies" "policies" {
  policies = [
    "${vault_policy.namespace_admin_policy.name}"
  ]
  exclusive = true
  entity_id = vault_identity_entity.namespace_admin.id
}

resource "vault_identity_entity_alias" "entity_alias" {
  name           = vault_identity_entity.namespace_admin.name
  mount_accessor = data.vault_auth_backends.Active_Directory.accessors[0]
  canonical_id   = vault_identity_entity.namespace_admin.id
}

resource "vault_policy" "namespace_admin_policy" {
  name   = "${var.entity_name}-policy"
  policy = <<EOT
# Manage namespaces
path "${vault_namespace.child_namespace.path}/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}
### AWS
### IF Same Region

data "aws_vpc" "dest_vpc" {
  id = var.dest_vpc_id
}
data "hcp_hvn" "vault_hvn" {
  hvn_id = var.hvn_id
}

### HCP
resource "hcp_aws_network_peering" "aws_connection" {
  hvn_id          = var.hvn_id
  peering_id      = "${var.Project_Account_ID}-${var.dest_region}-peering"
  peer_vpc_id     = data.aws_vpc.dest_vpc.id
  peer_account_id = data.aws_vpc.dest_vpc.owner_id
  peer_vpc_region = var.dest_region
}

resource "hcp_hvn_route" "hvn_to_aws" {
  hvn_link         = data.hcp_hvn.vault_hvn.self_link
  hvn_route_id     = "${var.Project_Account_ID}-${var.dest_region}-route"
  destination_cidr = data.aws_vpc.dest_vpc.cidr_block
  target_link      = hcp_aws_network_peering.aws_connection.self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.aws_connection.provider_peering_id
  auto_accept               = true
}
