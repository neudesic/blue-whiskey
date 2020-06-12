# Learn Terraform - Provision AKS Cluster

This repo is a companion repo to the [Provision an AKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-aks-cluster), containing
Terraform configuration files to provision an AKS cluster on
Azure.

After installing the Azure CLI and logging in. Create an Active Directory service
principal account.

```shell
$ az ad sp create-for-rbac --skip-assignment
{
  "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "displayName": "azure-cli-2019-04-11-00-46-05",
  "name": "http://azure-cli-2019-04-11-00-46-05",
  "password": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
  "tenant": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
}
```

Then, create a `terraform.override.tfvars` file, and create values with your `appId` and `password`. See `terraform.tfvars` file for reference. 
When you run any terraform commands add switch for var-file and specify the override file.

Examples
```shell
$ terraform init -var-file="terraform.override.tfvars" 
$ terraform plan -out out.tfplan -var-file="terraform.override.tfvars" 
$ terraform apply out.tfplan
```



```shell
$ terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "azurerm" (1.27.0)...

Terraform has been successfully initialized!
```


Then, provision your AKS cluster by running `terraform apply`. This will 
take approximately 10 minutes.

```shell
$ terraform apply

# Output truncated...

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

# Output truncated...

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_name = light-eagle-aks
resource_group_name = light-eagle-rg
```

## Configure kubectl

To configure kubetcl run the following command:

```shell
$ az aks get-credentials --resource-group light-eagle-rg --name light-eagle-aks;
```

The
[resource group name](https://github.com/hashicorp/learn-terraform-provision-aks-cluster/blob/master/aks-cluster.tf#L16)
and [AKS name](https://github.com/hashicorp/learn-terraform-provision-aks-cluster/blob/master/aks-cluster.tf#L25)
 correspond to the output variables showed after the successful Terraform run.

You can view these outputs again by running:

```shell
$ terraform output
```

## Configure Kubernetes Dashboard

To use the Kubernetes dashboard, we need to create a `ClusterRoleBinding`. This
gives the `cluster-admin` permission to access the `kubernetes-dashboard`.

```shell
$ kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
```

Finally, to access the Kubernetes dashboard, run the following command:

```shell
$ az aks browse --resource-group light-eagle-rg --name light-eagle-aks
Merged "light-eagle-aks" as current context in /var/folders/s6/m22_k3p11z104k2vx1jkqr2c0000gp/T/tmpcrh3pjs_
Proxy running on http://127.0.0.1:8001/
Press CTRL+C to close the tunnel...
```

 You should be able to access the Kubernetes dashboard at [http://127.0.0.1:8001/](http://127.0.0.1:8001/).

# File Guide
Files included in this repo

## Module Folders
```
# cluster-config 
Module defines kubernetes cluster. Invoked in main.tf

# db-config
Redundant module that defines postgres SQL server and database.

# mysql-db-config
Module used to define mySQL database

# vault-config
Module defining Azure Key Vault and secrets
```

## Main config files
```
# main.tf
Master terraform config file. Invokes all needed modules and generates random ID's

# outputs.tf
Master output file. Displays values after apply or output commands.

# terraform.tfvars
Assigns variable values needed to authorize terraform to interact with Azure
    
# variables.tf
Defines variables used in main.tf

# versions.tf
sets terraform version
```

## Monitoring
```
# container-azm-ms-agentconfig.yaml
manifest file that defines the data that prometheus will scrape from Kubernetes pod logs
```

## Cert Renewal - Nginx
```
# demo-ingress.ps1
# demo-ingress.sh
Script that creates ingress controller, SSL certificates, generates Kubernets secret

# demo-site-1.yaml
# demo-site-2.yaml
Manifest file that define two example nginx apps

# internal-ingress.yaml
Manifest file that defines an internal ingress controller

# update-cert.sh
Used to automate the renewal of an existing SSL certificate.
```

## Vault Demonstration - Wordpress Demo
```
# fetch-from-vault.sh
Retrieves secrets from previously defined Azure Key Vault and assigns them as env variables. Env variables used in wordpress-deployment.yaml

# wordpress-deployment.yaml
Manaifest file that creates wordpress app, PVC, and a service
    
# wordpress-ingress.sh
Main script file to create working environment. Creates internal and public ingress. Generates SSL certs. Creates kubernetes secret. Invokes fetch-from-vault.sh. Then deploys wordpress-deployment.yaml

# wordpress-ingress.yaml
Defines an internal ingress controller that is used to access wordpress application
```