# Keycloak on AKS using Terraform  
In this Project, we are going to **Deploying the keycloak applicaion** on Azure kubernates cluster and attach **Postgres Database** as presistance volum. All done using terraform and ansible. 

Step 1:
Connect with Azure through CLI.

Make kubernates cluster by running the files that are in terraform folder. Read the README file insdie the terraform folder for that. 


```
az account set --subscription <Sub-id>
az aks get-credentials --resource-group <resource-group> --name <cluster-name> --overwrite-existing
kubectl get deployments --all-namespaces=true

```
