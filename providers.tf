provider "ibm" {
  region = var.region
}

provider "dnsimple" {
  account = var.dnsimple_account
  token   = var.dnsimple_token
}

provider "digitalocean" {
  token = var.digital_ocean_token
}

