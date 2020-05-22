#resource "random_pet" "prefix" {}
provider "azurerm" {
  version = "~> 2.0.0"
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "Demo"
  }
}

resource "random_pet" "primary-cluster" {
  
}

resource "random_id" "primary-cluster" {
  byte_length = 10
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.primary-cluster.id}-${random_id.primary-cluster.dec}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "ln-k8s-clstr"

  ## Defines the type of VM's used to create the cluster
  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    # os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}