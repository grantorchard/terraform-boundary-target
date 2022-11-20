locals {
	name = "${var.project_id}-${var.app_name}"
}

resource "boundary_host_catalog_static" "this" {
	name = var.project_id
	scope_id = var.scope_id
}

resource "boundary_host_static" "this" {
	name = local.name
	address = var.target_address
	host_catalog_id = boundary_host_catalog_static.this.id
}

resource "boundary_host_set_static" "this" {
	type = "static"
	name = local.name
	host_catalog_id = boundary_host_catalog_static.this.id
	host_ids = [ boundary_host_static.this.id ]

}

resource "boundary_credential_library_vault" "read_only" {
  name                = "${var.project_id}-${var.app_name}-read-only."
  description         = "Read only credentials"
  credential_store_id = var.credential_store_id
  path                = var.read_only_path # change to Vault backend path
  http_method         = "GET"
  credential_type     = "username_password"
}

resource "boundary_target" "this" {
	name = "DB connection for ${local.name}"
	type = "tcp"
	scope_id = var.scope_id
	default_port = var.target_port
	brokered_credential_source_ids = [ boundary_credential_library_vault.read_only.id ]
	host_source_ids = [ boundary_host_set_static.this.id ]
}

