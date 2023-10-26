variable "disk-image" {
  type    = string
  default = "debian-cloud/debian-11"
}
variable "machine_type" {
  type    = string
  default = "e2-small"
}
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
variable "tag" {
  type = list(any)
}
variable "startup_script" {
  type        = string
  description = "Startup script for GCP instance"
}
