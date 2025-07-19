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


kubectl apply -f postgres-deployment.yaml -n keycloak
kubectl apply -f postgres-service.yaml -n keycloak

kubectl apply -f keycloak-deployment.yaml -n keycloak
kubectl apply -f keycloak-service.yaml -n keycloak

```

Make sure all pods are runing

```
kubectl get pod -n keycloak
```

For Debuging

```
kubectl logs <pod-name> -n keycloak
kubectl describe pod <pod-name> -n keycloak

```

To check previous logs 

```
kubectl logs <pod-name> -n keycloak --previous
kubectl logs <pod-name> -n keycloak --previous

```
To access the applicaiton you need to get the external IP adress and port  `htttp://http://xx.xx.xxx.xxx:8080/`

```
kubectl get svc -n keycloak

```



To make sure postgres is attach as presistance volume
```
kubectl describe pvc -n keycloak
```
