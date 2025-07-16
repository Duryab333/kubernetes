# kubernetes
Here I will share my knowledge about kubernates
Here I will be deploying my project task that I have to do as Part of my job interview

## Description
This project includes runing a Kubernates cluster on Azure. 
-  then deploying keyCloak applicaiton in one of its worker nodes.
-  Attaching it with postgress database for persistant volum
-  Make a system diagram 
### Question:
  -   How to do netowrking inside the kubernates cluster (DNS & Subnets)
  -   how many worker nodes should be use in kubernates cluster .
  -   how to attach postgress as persistancd volume.
  -   What is the purpose of using Helm ?

# Local Deployment

In this step I wil be deploying the applicaiotn localy in minikube cluser so lets start


Prerequisites
Install VirtualBox on the machine

Install Docker or Docker Desktop
Install kubectl CLI on machine
Install Minikube

```
minikube start  --driver=docker
minikube status
kubectl config use-context minikube
minikube addons list
minikube addons enable storage-provisioner # if not enable 
```

now 

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-postgresql bitnami/postgresql --version 15.1.4

```
now to check 

```
kubectl get all -n default

```

for linux 
```
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
echo $POSTGRES_PASSWORD
```


for windows 

```
$secret = kubectl get secret my-postgresql --namespace default -o jsonpath="{.data.postgres-password}"
$decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))
$env:POSTGRES_PASSWORD = $decoded
Write-Output $env:POSTGRES_PASSWORD

$secret = kubectl get secret my-postgresql --namespace default -o jsonpath="{.data.postgres-password}"
$POSTGRES_PASSWORD = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secret))


kubectl run my-postgresql-client `
  --rm --tty -i `
  --restart='Never' `
  --namespace default `
  --image docker.io/bitnami/postgresql:16.2.0-debian-12-r10 `
  --env="PGPASSWORD=$POSTGRES_PASSWORD" `
  --command -- psql --host my-postgresql -U postgres -d postgres -p 5432


# Get Minikube IP
$ip = minikube ip

# Download the ingress YAML
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak-ingress.yaml" -OutFile "keycloak-ingress.yaml"

# Replace placeholder with actual host
(Get-Content "keycloak-ingress.yaml") -replace "KEYCLOAK_HOST", "keycloak.$ip.nip.io" | Set-Content "keycloak-ingress.yaml"

# Apply the ingress
kubectl apply -f keycloak-ingress.yaml

minikube addons list     # to check for ingress is enable 
minikube addons enable ingress # enable if not
kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak.yaml
$ kubectl get all -n default


# Get Minikube IP
$ip = minikube ip

# Download the ingress YAML
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak-ingress.yaml" -OutFile "keycloak-ingress.yaml"

# Replace placeholder with actual host
(Get-Content "keycloak-ingress.yaml") -replace "KEYCLOAK_HOST", "keycloak.$ip.nip.io" | Set-Content "keycloak-ingress.yaml"

# Apply the ingress
kubectl apply -f keycloak-ingress.yaml



# Get the Minikube IP
$ip = minikube ip

# Construct the Keycloak URL
$KEYCLOAK_URL = "https://keycloak.$ip.nip.io"

# Display the URLs
Write-Host ""
Write-Host "Keycloak:                 $KEYCLOAK_URL"
Write-Host "Keycloak Admin Console:   $KEYCLOAK_URL/admin"
Write-Host "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account"
Write-Host ""

```

```
minikube tunnel
minikube service keycloak --url
```
start docker dekstop . then the applicaiotn will be runing 










