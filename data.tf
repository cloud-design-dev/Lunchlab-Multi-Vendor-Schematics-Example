data "digitalocean_image" "haproxy" {
  name = var.digital_ocean_image
}

data "ibm_is_zones" "mzr" {
  region = var.region
}

data "ibm_resource_group" "cde" {
  name = var.resource_group
}

data "ibm_is_ssh_key" "deploymentKey" {
  name = "hyperion-${var.region}"
}

data "ibm_is_vpc" "lunchlab" {
  name = "lunchlab-vpc"
}

data "ibm_is_subnet" "lunchlab" {
  name = "lunchlab-zone-1-subnet"
}