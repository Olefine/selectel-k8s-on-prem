project_name = "spicyexperiments"
instance_image_name = "Ubuntu 22.04 LTS 64-bit"

master_flavor = {
  name: "k8s-master"
  vcpus: 2
  ram_mb: 4096
  local_disk_gb: 16
}

worker_flavor = {
  name: "k8s-worker"
  vcpus: 1
  ram_mb: 2048
  local_disk_gb: 16
}

available_zone = "ru-3b"
subnet_cidr = "192.168.0.0/24"
