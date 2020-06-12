#resource "random_pet" "prefix" {}
resource "azurerm_kubernetes_cluster" "default" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "ln-k8s-clstr"

  ## Defines the type of VM's used to create the cluster
  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    # os_type         = "Linux"
    os_disk_size_gb = 30
  }

  addon_profile{
    kube_dashboard {
      enabled = true
    }
    oms_agent{
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.primary.id      
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }

  depends_on = [var.resource_group_name]

}

resource "random_id" "workspace" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = var.resource_group_name
  }

  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "primary" {
  name                = "k8s-workspace-${random_id.workspace.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "primary" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.primary.id
  workspace_name        = azurerm_log_analytics_workspace.primary.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}