provider "azurerm" {
  version = "~> 2.8.0"
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "Demo"
  }
}

#generates random name and ID for kubernetes cluster
resource "random_pet" "primary-cluster" {
}
resource "random_id" "primary-cluster" {
  byte_length = 10
}

#create/update kubernetes cluster
module "cluster-config" {
  source = "./modules/cluster-config"

  name                = "${random_pet.primary-cluster.id}-${random_id.primary-cluster.dec}"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name

  #authentication
  client_id           = var.appId
  client_secret       = var.password

}

#generates random name and ID for db
resource "random_pet" "primary" {
}
resource "random_id" "primary" {
  byte_length = 10
}

#generate db server admin password for postgres
resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

#postgres db-config module
module "db-config" {
  source                = "./modules/db-config"
  location              = var.location
  resource_group_name   = azurerm_resource_group.default.name

  server_name           = "${random_pet.primary.id}-${random_id.primary.dec}"
  postgresql_admin_name = "lnadmin"
  postgresql_admin_pass = random_password.password.result
  
}

#generates random name and ID for mysql-db
resource "random_pet" "primary-mysql" {
}
resource "random_id" "primary-mysql" {
  byte_length = 10
}

#generate db server admin password for mysql
resource "random_password" "password-mysql" {
  length = 16
  special = true
  override_special = "_%@"
}

#mysql db-config module
module "mysql-db-config" {
  source                = "./modules/mysql-db-config"
  
  location              = var.location
  resource_group_name   = azurerm_resource_group.default.name

  mysql_server_name     = "${random_pet.primary-mysql.id}-${random_id.primary-mysql.dec}"
  mysql_admin_name      = "lnadmin-mysql"
  mysql_admin_pass      = random_password.password-mysql.result
}


#generates random name for azure key vault
resource "random_pet" "primary-vault" {
  length = 2
}

#create/update azure key vault
module "vault-config" {
  source = "./modules/vault-config"

  primary-vault       = "${random_pet.primary-vault.id}-bw"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name

  secret_name_1       = "bw-server-fqdn"
  secret_value_1      = module.db-config.postgresql_server_fqdn

  secret_name_2       = "bw-server-port"
  secret_value_2      = module.db-config.postgresql_port

  secret_name_3       = "bw-server-admin-login"
  secret_value_3      = module.db-config.postgresql_admin_login_name

  secret_name_4       = "bw-server-admin-password"
  secret_value_4      = module.db-config.postgresql_admin_password

  secret_name_5       = "bw-server-fqdn-mysql"
  secret_value_5      = module.mysql-db-config.mysql_server_fqdn

  secret_name_6       = "bw-server-port-mysql"
  secret_value_6      = module.mysql-db-config.mysql_port

  secret_name_7       = "bw-server-admin-login-mysql"
  secret_value_7      = module.mysql-db-config.mysql_admin_login_name

  secret_name_8       = "bw-server-admin-password-mysql"
  secret_value_8      = module.mysql-db-config.mysql_admin_password
  # tags = {
  #   Terraform   = "true"
  #   Environment = "dev"
  # }
}