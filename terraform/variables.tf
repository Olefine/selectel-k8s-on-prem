variable "selectel_account_id" {}

variable "openstack_auth_url" {
  description = "OpenStack auth URL"
  type = string
}

variable "project_name" {
  description = "Main project name"
  type = string
}

variable "project_user_name" {
  description = "Project's owner username"
  type = string
}

variable "project_user_password" {
  description = "Project's owner password"
  type = string
}

variable "project_user_keypair_path" {
  description = "Project's owner public key path"
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "instance_image_name" {
  description = "Instance Image full name"
  type = string
}

variable "master_flavor" {
  description = "Selectel master flavor details"
  type = object({
    name: string
    vcpus: number
    ram_mb: number
    local_disk_gb: number
  })
}

variable "worker_flavor" {
  description = "Selectel worker flavor details"
  type = object({
    name: string
    vcpus: number
    ram_mb: number
    local_disk_gb: number
  })
}

variable "available_zone" {
  description = "Available Selectel zone"
  type = string
}

# Network
variable "router_external_net_name" {
  description = "External network name"
  type = string
  default = "external-network"
}

variable "dns_nameservers" {
  description = "Selectel DNS"
  type = list(string)
  default = [
    "188.93.16.19",
    "188.93.17.19",
  ]
}

variable "subnet_cidr" {
  description = "Public subnet cidr"
  type = string
}

variable "ansible_template_conf" {
  description = "User and private key path needed to build ansible inventory"
  type = object({
    user = string
    user_pkey_path = string
  })
}