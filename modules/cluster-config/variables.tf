#Variable file for cluster-config module

variable "name" {
  description = "Name of kubernetes cluster"
}

variable "location" {
  description = "Location of the resources in this module"
}

variable "resource_group_name" {
  description = "Resource group in which module will be built"
}

variable "client_id" {
  description = "ID of the service principal that authenticates terraform"
}

variable "client_secret" {
  description = "client secret of the service principal that authenticates terraform"
}

