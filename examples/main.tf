module "boundary_target" {
  source = "./modules"

  credential_store_id = var.credential_store_id
  read_only_path      = var.read_only_path
  scope_id            = var.scope_id
  target_port         = var.target_port
	target_address = var.target_address

	app_name = "database"
	project_id = "2111"
}