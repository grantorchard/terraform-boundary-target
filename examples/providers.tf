provider "boundary" {
	addr                            = var.boundary_addr
  auth_method_id                  = "ampw_7HBv1E399l"
  password_auth_method_login_name = var.boundary_username
  password_auth_method_password   = var.boundary_password
}