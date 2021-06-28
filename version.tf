terraform {
  required_providers {
    dnsimple = {
      source  = "dnsimple/dnsimple"
      version = "0.5.3"
    }
    ibm = {
      source = "IBM-Cloud/ibm"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.9.0"
    }
  }
}
