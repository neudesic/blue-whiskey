#variables for mysql-db-config module
variable "location" {
  description = "Location of the resources in this module"
}

variable "resource_group_name" {
  description = "Resource group in which module will be built"
}

variable "mysql_server_name" {
  description = "Name of the databse server"
}

variable "mysql_admin_name" {
    description = "admin username for postgres server"
}

variable "mysql_admin_pass" {
    description = "admin password for postgres server"
}
