#variables for db-config module
variable "location" {
  description = "Location of the resources in this module"
}

variable "resource_group_name" {
  description = "Resource group in which module will be built"
}

variable "server_name" {
  description = "Name of the databse server"
}

variable "postgresql_admin_name" {
    description = "admin username for postgres server"
}

variable "postgresql_admin_pass" {
    description = "admin password for postgres server"
}
