variable "resource_group" {
  default = "CDE"
}
variable "region" {
  default = "eu-de"
}

variable "tags" {
  default = ["owner:ryantiffany"]
}

variable "digital_ocean_token" {}
variable "dnsimple_token" {}
variable "dnsimple_account" {}
variable "digital_ocean_image" {
  default = "openfaas-18-04"
}

variable "dnsimple_domain" {
  default = "cdetesting.com"
}

variable "name" {
}
