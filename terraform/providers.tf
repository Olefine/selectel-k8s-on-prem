provider "openstack" {
  user_name           = var.project_user_name
  password            = var.project_user_password
  tenant_name         = var.project_name
  project_domain_name = var.selectel_account_id
  user_domain_name    = var.selectel_account_id
  region              = substr(var.available_zone, 0, 4)
  auth_url = var.openstack_auth_url
}