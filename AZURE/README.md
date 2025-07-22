# Keycloak on AKS using CLI
In this Project, we are going to **Deploying the keycloak applicaion** on Azure kubernates cluster and attach **Postgres Database** as presistance volum. All done using terraform and ansible. 

### Step 1:
Connect with Azure through CLI.

### Step 2:
Go to Terrafrom folder and make resuorces on AZURE. You will find guid in Terrafrom/README.md file

### Step 3:
Make kubernates cluster by running the files that are in terraform folder. Read the README file insdie the terraform folder for that. 
(!MAKE SURE YOU WRITE YOU WON terrafrom.tfvars file)
### Step 4:
After Making resources go to ansible folder there you run ansible-playbook.
(!MAKE SURE YOU PUT WRITE VARIABLES )

Ansible-playbook will give you output urls on which your keycloak and  web server with a static web page are runing

### NEXT Step :

Netstep is to authenticate web server with a static web page whose access is
controlled by the Keycloak.

# Report 
