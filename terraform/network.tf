resource "openstack_networking_network_v2" "network" {
  name = "${var.project_name}-default-network"
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.project_name}-router"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

resource "openstack_networking_router_interface_v2" "router_iface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_networking_subnet_v2" "subnet" {
  network_id      = openstack_networking_network_v2.network.id
  dns_nameservers = var.dns_nameservers
  name            = "${var.project_name}-public-subnet"
  cidr            = var.subnet_cidr
}

resource "openstack_networking_port_v2" "master-eth0" {
  name       = "${var.project_name}-master-eth0"
  network_id = openstack_networking_network_v2.network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet.id
  }
}

resource "openstack_networking_port_v2" "worker-eth0" {
  name       = "${var.project_name}-worker-eth0"
  network_id = openstack_networking_network_v2.network.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet.id
  }
}


# Creating a public IP
resource "openstack_networking_floatingip_v2" "master-public_ip" {
  pool = var.router_external_net_name
}

resource "openstack_networking_floatingip_v2" "worker-public_ip" {
  pool = var.router_external_net_name
}

resource "openstack_networking_floatingip_associate_v2" "master-floatingip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.master-public_ip.address
  port_id     = openstack_networking_port_v2.master-eth0.id
}

resource "openstack_networking_floatingip_associate_v2" "worker-floatingip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.worker-public_ip.address
  port_id     = openstack_networking_port_v2.worker-eth0.id
}
