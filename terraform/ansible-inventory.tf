resource "local_file" "ansible_inventory" {
  content = templatefile("templates/ansible-inventory.tmpl",
    {
      prefix = var.project_name
      user = var.ansible_template_conf.user
      ssh_private_key_file = var.ansible_template_conf.user_pkey_path
      master_ip = openstack_networking_floatingip_v2.master-public_ip.address
      worker_ips = [openstack_networking_floatingip_v2.worker-public_ip.address]
    }
  )
  filename = "../ansible/hosts"

  file_permission = "600"

  depends_on = [openstack_networking_floatingip_v2.master-public_ip, openstack_networking_floatingip_v2.worker-public_ip]
}