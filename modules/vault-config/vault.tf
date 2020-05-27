# resource "random_id" "primary-vault" {
#   byte_length = 3
# }

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "primary" {
  name                        = var.primary-vault
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  sku_name = "standard"

# Will's personal object ID
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "07502c44-43ff-4d84-98d9-8bc5898184a6"

    key_permissions = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge","recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey"]

    secret_permissions = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]

    storage_permissions = [ "backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update" ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge","recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey"]

    secret_permissions = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]

    storage_permissions = [ "backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update" ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = ["107.11.55.188/32", "24.131.166.180/32"]
  }

  tags = {
    environment = "Demo"
  }

  depends_on = [var.resource_group_name]
}

#secret_name_1
resource "azurerm_key_vault_secret" "bw_server_fqdn" {
  name         = var.secret_name_1
  value        = var.secret_value_1
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_2
resource "azurerm_key_vault_secret" "bw_server_port" {
  name         = var.secret_name_2
  value        = var.secret_value_2
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_3
resource "azurerm_key_vault_secret" "bw_server_admin_login" {
  name         = var.secret_name_3
  value        = var.secret_value_3
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_4
resource "azurerm_key_vault_secret" "bw_server_admin_password" {
  name         = var.secret_name_4
  value        = var.secret_value_4
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_5
resource "azurerm_key_vault_secret" "bw_server_fqdn_mysql" {
  name         = var.secret_name_5
  value        = var.secret_value_5
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_6
resource "azurerm_key_vault_secret" "bw_server_port_mysql" {
  name         = var.secret_name_6
  value        = var.secret_value_6
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_7
resource "azurerm_key_vault_secret" "bw_server_admin_login_mysql" {
  name         = var.secret_name_7
  value        = var.secret_value_7
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}

#secret_name_8
resource "azurerm_key_vault_secret" "bw_server_admin_password_mysql" {
  name         = var.secret_name_8
  value        = var.secret_value_8
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}