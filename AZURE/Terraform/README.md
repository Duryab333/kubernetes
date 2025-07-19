# Terraform Readme

This folder contains fils to make a AKS cluster with auto scaling of pods 1-3. 
You need to make your own `terraform.tfvars` file and give vaules of input variables in it 
example
```
resource_group_name = "YOUR_RESOURCE_GROUP_NAME"
location = "LOCATION"
cluster_name = "CLUSTER_NAME"
kubernates_version = "K8S_VERSION"
worker_node_count= NUMBER_OF_NODES
acr_name = "CONTAINER_NAME"
dns_prefix = "DNS_PREFIX_NAME"
vm_size = "VM_SIZE" #"Standard_E2s_v3"
subscription_id = "YOUR_SUBSCRIPTION_ID"
```

Do `terraform.ini` and `terraform plan` and if all goes right then `terraform apply` to make resources on AZURE
