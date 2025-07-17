variable "resource_group_name" {
    type = string
    description = "resource group name in Azure"
  
}
variable "location" {
    type = string
    description = "resource locaiton in Azure"
  
}
variable "vm_size" {
    type = string
  
}
variable "cluster_name" {
    type = string
    description = "AKS name in Azure"
  
}
variable "kubernates_version" {
    type = string
    description = "Kubernates version"
}
variable "worker_node_count" {
    type = string
    description = "number of AKS worker nodes"
  
}
variable "subscription_id" {
    type = string
  
}
variable "acr_name" {
    type = string
    description = "ACR name"
}
variable "dns_prefix" {
    type = string
    description = "DNS prefix name"
  
}