# Ansible 

After making the resources on terraform you need to run ansible playbook.yml to deploy keylcoak on pode.

## Pre-requizits

-  install ansible

change the directory. be in AZURE/ansible.
Run commands 


To Run ansible playbook 

```
ansible-playbook keycloak-deploy.yaml   --extra-vars "subscription_id= <subscription_id> resource_group=<rg_name> cluster_name=<cluster_name>"

```

## Tip:

if you are using WSL for runin glinux on windows and find error is 

`ERROR :The connection to the server localhost:8080 was refused`

This means kubectl is trying to connect to a Kubernetes API server at localhost:8080, which usually happens when your Kubeconfig isn’t loaded properly inside WSL.

```
 az account set --subscription <subscription_id>
 az aks get-credentials --resource-group <rg_name> --name <cluster_name> --overwrite-existing

```

Copy the config into WSL
From WSL, run:
```
mkdir -p ~/.kube
cp /mnt/c/Users/YOUR_DIR/.kube/config ~/.kube/config

```

Then verify:

```

kubectl config current-context
kubectl get nodes

```
