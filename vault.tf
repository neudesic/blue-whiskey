resource "random_pet" "primary-vault" {
  length = 2
}

# resource "random_id" "primary-vault" {
#   byte_length = 3
# }

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "primary" {
  name                        = "${random_pet.primary-vault.id}-bw"
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
    ip_rules       = ["107.11.55.188", "24.131.166.180"]
  }

  tags = {
    environment = "Demo"
  }

  depends_on = [azurerm_resource_group.default]
}

# resource "azurerm_key_vault_secret" "example-secret-bw" {
#   name         = "secret-sauce"
#   value        = "szechuan"
#   key_vault_id = azurerm_key_vault.primary.id

#   tags = {
#     environment = "Demo"
#   }
# }

resource "azurerm_key_vault_secret" "bw_server_fqdn" {
  name         = "bw-server-fqdn"
  value        = azurerm_postgresql_server.test.fqdn
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}
resource "azurerm_key_vault_secret" "bw_server_port" {
  name         = "bw-server-port"
  value        = "5432"
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}
resource "azurerm_key_vault_secret" "bw_server_admin_login" {
  name         = "bw-server-admin-login"
  value        = var.postgresql_admin_name
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}
resource "azurerm_key_vault_secret" "bw_server_admin_password" {
  name         = "bw-server-admin-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.primary.id

  tags = {
    environment = "Demo"
  }
}