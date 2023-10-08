data "openstack_images_image_v2" "instance_image" {
  name        = var.instance_image_name
  visibility  = "public"
  most_recent = true
}

data "openstack_networking_network_v2" "external_net" {
  name     = var.router_external_net_name
  external = true
}