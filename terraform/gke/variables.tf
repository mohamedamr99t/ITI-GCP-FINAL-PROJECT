variable "network-subnet" {
  type = object({
    region  = string
    project = string
    name    = string
    network = string

  })
}
variable "service_account_email" {
  type = string
}
variable "authorized_networks_cidr_range" {
  type = string
}