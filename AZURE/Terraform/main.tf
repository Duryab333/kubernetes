resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "azureKubernates" {
  depends_on = [azurerm_resource_group.aks-rg]
  name                = var.cluster_name
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version = var.kubernates_version
   node_resource_group = "${var.resource_group_name}-nrg"

  # default_node_pool {
  #   name       = "default"
  #   node_count = 1
  #   vm_size    = var.vm_size
  #   temporary_name_for_rotation = "tmpnodepool1"
  # }
   default_node_pool {
    name       = "defaultpool"
    vm_size    = var.vm_size
    zones   = [1, 2, 3]
    auto_scaling_enabled = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30 
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
     } 
    tags = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
   } 
  }
   service_principal {
    client_id     =  var.client_id 
    client_secret =  va.client_secret
  }
   network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

}


  resource "azurerm_kubernetes_cluster_node_pool" "cluster_pool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.azureKubernates.id
  vm_size               = var.vm_size
  node_count            = 1
  os_disk_size_gb = 30



  tags = {
    Environment = "dev"
  }
}
