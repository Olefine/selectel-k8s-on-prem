resource "openstack_compute_flavor_v2" "master_flavor" {
  name  = var.master_flavor.name
  vcpus = var.master_flavor.vcpus
  ram   = var.master_flavor.ram_mb
  disk  = var.master_flavor.local_disk_gb

  lifecycle {
    create_before_destroy = true
  }
}

resource "openstack_compute_flavor_v2" "worker_flavor" {
  name  = var.worker_flavor.name
  vcpus = var.worker_flavor.vcpus
  ram   = var.worker_flavor.ram_mb
  disk  = var.worker_flavor.local_disk_gb

  lifecycle {
    create_before_destroy = true
  }
}

resource "openstack_compute_instance_v2" "master" {
  name              = "${local.compute_instance_prefix}-master"
  image_id          = data.openstack_images_image_v2.instance_image.id
  flavor_id         = openstack_compute_flavor_v2.master_flavor.id
  key_pair          = var.project_user_name
  availability_zone = var.available_zone

  network {
    port = openstack_networking_port_v2.master-eth0.id
  }

  network {
    uuid = openstack_networking_network_v2.network.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}

resource "openstack_compute_instance_v2" "worker" {
  name              = "${local.compute_instance_prefix}-worker"
  image_id          = data.openstack_images_image_v2.instance_image.id
  flavor_id         = openstack_compute_flavor_v2.worker_flavor.id
  key_pair          = var.project_user_name
  availability_zone = var.available_zone

  network {
    port = openstack_networking_port_v2.worker-eth0.id
  }

  network {
    uuid = openstack_networking_network_v2.network.id
  }

  lifecycle {
    ignore_changes = [image_id]
  }

  vendor_options {
    ignore_resize_confirmation = true
  }
}
