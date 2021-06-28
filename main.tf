resource "digitalocean_droplet" "openfaas" {
  image  = var.digital_ocean_image
  name   = "openfaas"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  tags   = concat(var.tags, ["region:nyc2", "project:${var.name}", "provider:digitalocean", "type:droplet"])
}

resource "dnsimple_record" "openfaas" {
  domain = var.dnsimple_domain
  name   = "openfaas"
  value  = digitalocean_droplet.openfaas.ipv4_address
  type   = "A"
  ttl    = 3600
}

module "ubuntu" {
  count = 4
  source            = "git::https://github.com/cloud-design-dev/IBM-Cloud-VPC-Instance-Module.git"
  vpc_id            = data.ibm_is_vpc.lunchlab.id
  subnet_id         = data.ibm_is_subnet.lunchlab.id
  ssh_keys          = [data.ibm_is_ssh_key.deploymentKey.id]
  allow_ip_spoofing = false
  resource_group_id = data.ibm_resource_group.cde.id
  name              = "${var.name}-ubuntu-${count.index +1}"
  zone              = data.ibm_is_zones.mzr.zones[0]
  security_groups   = [data.ibm_is_vpc.lunchlab.default_security_group]
  tags              = concat(var.tags, ["region:${var.region}", "project:${var.name}", "provider:ibmcloud", "zone:${data.ibm_is_zones.mzr.zones[0]}", "type:instance"])
  user_data         = file("${path.module}/install.yml")
}

resource "ibm_is_floating_ip" "ubuntu" {
  name           = "ubuntu-fip"
  resource_group = data.ibm_resource_group.cde.id
  target         = module.ubuntu.primary_network_interface_id
}

resource "dnsimple_record" "vpc_instance" {
  domain = var.dnsimple_domain
  name   = "ubuntu"
  value  = ibm_is_floating_ip.ubuntu.address
  type   = "A"
  ttl    = 3600
}
