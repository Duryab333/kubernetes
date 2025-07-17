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

In this step I wil be deploying the minikube cluser locally. and install Keycloak inside it in so lets start
This deplyment is for windowns &linux

### Prerequisites

-  Install Docker or Docker Desktop
-  Install kubectl CLI on machine
-  Install Minikube

#### Step 1 
-  Start Minikube
-  Verify that Minikube is running
-  Set up the Kubernetes context to point to Minikube
```
minikube start  --driver=docker
minikube status
kubectl config use-context minikube
```
#### Step 2
**Deploying Keycloak on Kubernetes**

PostgreSQL Database Setup

Keycloak requires a database backend for storing configuration data.

```
minikube addons list
# as per the result storage-provisioner is already enabled on minikube if not then execute this command
minikube addons enable storage-provisioner 
```

Deploy PostreSQL using Helm Chart

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-postgresql bitnami/postgresql --version 15.1.4

```

now to Check PGSQl Deployment

```
kubectl get all -n default

```

#### Step 3

**Retrieve PgSQL Password and Connect to PgSQL to validate connection**
 
For linux 


```
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
echo $POSTGRES_PASSWORD
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
kubectl run my-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:16.2.0-debian-12-r10 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
      --command -- psql --host my-postgresql -U postgres -d postgres -p 5432
```
or 

For windows 

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

```

#### Step 4

**KeyCloak Setup**

Enable Ingress Addon: To check if you have the Ingress addon enabled, enter the following command:

```
minikube addons list | grep 'ingress'
minikube addons enable ingress # If the Ingress addon is not enabled,
```

**Deploy KeyClock Deployment & Services**


```
kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak.yaml
$ kubectl get all -n default

```

#### Step 5
Create Ingress: Create an Ingress for Keycloak by entering the following command

For linux 

```
wget -q -O - https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak-ingress.yaml | \
sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" | \
kubectl create -f -
```

or for windows

```
# Get Minikube IP
$ip = minikube ip

# Download the ingress YAML
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak-ingress.yaml" -OutFile "keycloak-ingress.yaml"

# Replace placeholder with actual host
(Get-Content "keycloak-ingress.yaml") -replace "KEYCLOAK_HOST", "keycloak.$ip.nip.io" | Set-Content "keycloak-ingress.yaml"

# Apply the ingress
kubectl apply -f keycloak-ingress.yaml

```

To check if the ingress enable 

```
minikube addons list     # to check for ingress is enable 
minikube addons enable ingress # enable if not

```

#### Step 6
Execute below commands to get KeyCloak URls

For linux: 

```
KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io &&
echo "" &&
echo "Keycloak:                 $KEYCLOAK_URL" &&
echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" &&
echo ""
```

For Windows

```


# Construct the Keycloak URL
$KEYCLOAK_URL = "https://keycloak.$ip.nip.io"

# Display the URLs
Write-Host ""
Write-Host "Keycloak:                 $KEYCLOAK_URL"
Write-Host "Keycloak Admin Console:   $KEYCLOAK_URL/admin"
Write-Host "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account"
Write-Host ""

```



#### Step 7
```
minikube tunnel
minikube service keycloak --url
```
Make sure start docker or docker dekstop is running in background 

Now you can access the applicaiton by the URL you get from runing the tunnel or by taking the url of keycloak service 
login to applicaion with username=admin & password =admin
Then create the usergroup , assign permisions to it , the create a user and attach user with the group. 

**Valide of Stroage**

Now to connect to database and quey for validaion

```

kubectl exec -it <postgres-pod-name> -n keycloak -- bash
psql -U keycloak -d keycloak

```
then run Query inside it to see the users details 

```

SELECT * FROM user_entity;
```










