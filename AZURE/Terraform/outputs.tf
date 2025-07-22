/*

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}


*/

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.azureKubernates.kube_config[0].client_certificate
  sensitive = true
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.azureKubernates.kube_config_raw

  sensitive = true
}
