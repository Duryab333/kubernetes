# AKS-Based Static Site Deployment with Keycloak Authentication
In this Project, we are going to **Deploying the keycloak applicaion** on Azure kubernates cluster and attach **Postgres Database** as presistance volum. All done using terraform and ansible. 


<img width="1617" height="564" alt="image" src="https://github.com/user-attachments/assets/a35bab4c-c3cb-4d58-8435-2f02976324fa" />


### Steps :
-  Connect with Azure through CLI.

-  Go to Terrafrom folder and make resuorces on AZURE. You will find guid in Terrafrom/README.md file

-  Make kubernates cluster by running the files that are in terraform folder. Read the README file insdie the terraform folder for that.  (!MAKE SURE YOU WRITE YOU WON terrafrom.tfvars file)

-  After Making resources go to ansible folder there you run ansible-playbook. (!MAKE SURE YOU PUT WRITE VARIABLES )

-  Ansible-playbook will give you output urls on which your keycloak and  web server with a static web page are runing

### NEXT Steps :

-  Netstep is to authenticate web server with a static web page whose access is
controlled by the Keycloak. 
-  GitHub Actions for CI/CD automation.


# Report 

## Overview

In this project, I have created and automated the deployment of a Kubernetes-based web application infrastructure on Azure Kubernetes Service (AKS). The key goal was to expose a static website securely through Keycloak authentication, using oauth2-proxy. The entire setup is automated using Terraform for infrastructure provisioning and Ansible for workload deployment.


## Infrastructure Provisioning with Terraform
Using Terraform:

-  Created a Resource Group in Azure.

-  Defined a Virtual Network and subnets to host the AKS cluster.

-  Deployed an AKS cluster within the virtual network.

   - The cluster supports auto-scaling (up to 3 nodes) to handle traffic load dynamically.

   - The worker nodes are configured with VM size: Standard_B2s, which is cost-effective and provides 2 vCPUs and 4 GB RAM—suitable for small-scale deployments and containerized applications like Keycloak, Postgres, and a static site.

   - Networking uses Azure CNI for Pod IP allocation, ensuring Pods receive IPs from the VNet and can communicate across services and resources securely and directly.
 
  ## Cluster Configuration with Ansible
 Once the cluster was created, I used Ansible to configure the environment:

**1. Nginx Ingress Controller :** 

Deployed Nginx Ingress to expose internal services to the internet. The public IP assigned to the ingress is dynamically injected into other service configurations (Keycloak and the static site) using Ansible templating.

**2. PostgreSQL Database :** 
Deployed PostgreSQL as a persistent database backend for Keycloak, using a dedicated PVC (PersistentVolumeClaim).

**3. Keycloak Identity Server :** 
Deployed Keycloak and connected it to the PostgreSQL database. This service handles authentication and user management. It's accessible publicly at:
`http://keycloak.<external-ip>.nip.io`
<img width="956" height="917" alt="image" src="https://github.com/user-attachments/assets/3a8ac3ad-177a-4e7c-b08a-0cd7aaf4065a" />
<img width="1877" height="941" alt="image" src="https://github.com/user-attachments/assets/3ccda206-4051-44b6-8546-9f9b4ad758c8" />


**4. Static Website :** 
Deployed a basic HTML-based static site using a Kubernetes pod and service. It is served through Ingress at:
`http://static.<external-ip>.nip.io`
<img width="1043" height="599" alt="image" src="https://github.com/user-attachments/assets/cf041917-b48d-42ba-b26b-0abefd3a7771" />


**5. OAuth2-Proxy Configuration :** 

- Deployed oauth2-proxy in front of the static site to enforce OAuth2 login.

- Configured oauth2-proxy to use Keycloak as the OAuth2 provider.

- In Keycloak:

  - Created a new Realm and Client.
  - <img width="825" height="571" alt="image" src="https://github.com/user-attachments/assets/a2981524-d6ab-499f-99d4-2a1b98397663" />


  - Set the correct redirect URIs (e.g. `http://static.<external-ip>.nip.io/oauth2/callback`).
  - <img width="1110" height="610" alt="image" src="https://github.com/user-attachments/assets/0d2219fe-b088-42dd-abd9-6857b5d1f71c" />


  - Created user accounts to test login.
 
  ##  Authentication Flow

1. User accesses the static website (/ path).

2. oauth2-proxy intercepts and redirects the user to Keycloak login.

3. After successful login, oauth2-proxy redirects the user back to the static page with access.

✅ This flow ensures only authenticated users can access the static content, making it suitable for internal dashboards, restricted tools, etc.

## 🚧 Work In Progress
I am currently finalizing the Ansible playbook automation for oauth2-proxy 
Next is making github flows


## 📁 GitHub Repository
You can find all the Terraform, Ansible, and Kubernetes manifests used in this project here:
👉 GitHub - Duryab333/kubernetes




