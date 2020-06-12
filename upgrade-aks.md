# How to upgrade AKS cluster

## To find out if you have upgrades available

```sh
az aks get-upgrades --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME> --output table
```

### Example Output

Name | Resource Group | Master Version | Upgrades | 
---- | -------------- | -------------- | -------- | 
default | LexisNexis1 | 1.15.11 | 1.16.8, 1.16.9 | 

# Enable node surge (in Preview)
## Example

Cluster has 5 node pools, each with 4 nodes = 20 nodes, max surge set to 50% = additional 10 nodes (2 nodes * 5 pools)

Microsoft recommended value of surge nodes is 33% so need to make sure cluster can support additional nodes.

By default, AKS configures upgrades to surge with one additional node. A default value of one for the max surge setting enables AKS to minimize workload disruption by creating an additional node before the cordon/drain of existing applications to replace an older versioned node.

```sh

# Register the preview feature

az feature register --namespace "Microsoft.ContainerService" --name "MaxSurgePreview"


# Verify the feature is registered:

az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/MaxSurgePreview')].{Name:name,State:properties.state}"


# Install the aks-preview extension

az extension add --name aks-preview


# Update the extension to make sure you have the latest version installed

az extension update --name aks-preview

# find out what nodepools a cluster has
az aks nodepool list --resource-group <RESOURCE_GROUP>  --cluster-name <AKS_CLUSTER_NAME>

# Do one of these two commands depending on if it is a new node pool or existing

# Set max surge for a new node pool

az aks nodepool add -n mynodepool -g <RESOURCE_GROUP> --cluster-name <AKS_CLUSTER_NAME> --max-surge 33%


# Update max surge for an existing node pool 

az aks nodepool update -n mynodepool -g <RESOURCE_GROUP> --cluster-name <AKS_CLUSTER_NAME> --max-surge 5

```

# Upgrade

```sh

# Upgrade to version 1.16.8
az aks upgrade --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME> --kubernetes-version 1.16.8

```

**Note**

Estimated amount of time to update `each` node is 10 minutes.  
