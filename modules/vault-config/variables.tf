#variable file for vault-config file

variable "primary-vault" {
    description = "Name of the main Azure Key Vault"
    type = string
}

variable "location" {
    description = "Location of the resources in this module"
}

variable "resource_group_name" {
  description = "Resource group in which module will be built"
}

#bw_server_fqdn
variable "secret_name_1" {
  description = "Name of secret"
}
variable "secret_value_1" {
  description = "Value of secret"
}

#bw_server_port
variable "secret_name_2" {
  description = "Name of secret"
}
variable "secret_value_2" {
  description = "Value of secret"
}

#bw_server_admin_login
variable "secret_name_3" {
  description = "Name of secret"
}
variable "secret_value_3" {
  description = "Value of secret"
}

#bw_server_admin_password
variable "secret_name_4" {
  description = "Name of secret"
}
variable "secret_value_4" {
  description = "Value of secret"
}

#bw_server_fqdn_mysql
variable "secret_name_5" {
  description = "Name of secret"
}
variable "secret_value_5" {
  description = "Value of secret"
}

#bw_server_port_mysql
variable "secret_name_6" {
  description = "Name of secret"
}
variable "secret_value_6" {
  description = "Value of secret"
}

#bw_server_admin_login_mysql
variable "secret_name_7" {
  description = "Name of secret"
}
variable "secret_value_7" {
  description = "Value of secret"
}

#bw_server_admin_password_mysql
variable "secret_name_8" {
  description = "Name of secret"
}
variable "secret_value_8" {
  description = "Value of secret"
}

