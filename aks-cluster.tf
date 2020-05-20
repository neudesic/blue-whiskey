#resource "random_pet" "prefix" {}

variable "appId" {
}

variable "password" {
}

provider "azurerm" {
  version = "~> 1.27.0"
}

resource "azurerm_resource_group" "default" {
  name     = "test-name-1rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "test-name-1aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "test-name-1k8s"

  ## Defines the type of VM's used to create the cluster
  agent_pool_profile {
    name            = "default"
    count           = 2
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
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
