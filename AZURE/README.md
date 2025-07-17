# Keycloak on AKS using Terraform  
In this Project, we are going to **Deploying the keycloak applicaion** on Azure kubernates cluster and attach **Postgres Database** as presistance volum. All done using terraform and ansible. 

Step 1:
Connect with Azure through CLI.

Make kubernates cluster by running the files that are in terraform folder. Read the README file insdie the terraform folder for that. 


```
az account set --subscription <Sub-id>
az aks get-credentials --resource-group <resource-group> --name <cluster-name> --overwrite-existing
kubectl get deployments --all-namespaces=true

kubectl get pods

kubectl create namespace keycloak


kubectl apply -f postgres-deployment.yaml
kubectl apply -f keycloak-deployment.yaml

kubectl get pod -n keycloak

kubectl logs <postgres-pod-name> -n keycloak
kubectl describe pod <keycloak-pod-name> -n keycloak

kubectl apply -f keycloak-service.yaml
kubectl apply -f postgres-service.yaml

kubectl logs <keycloak-pod-name> -n keycloak --previous
kubectl logs <postgres-pod-name> -n keycloak --previous

kubectl get svc -n keycloak
kubectl describe pvc -n keycloak
```
