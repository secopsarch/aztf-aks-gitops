#!/bin/bash

# Variables
RESOURCE_GROUP="akslab02"           # Resource group name
CLUSTER_NAME="test-aks02"           # AKS cluster name
NODE_COUNT=1                        # Number of nodes to start with
VM_SIZE="Standard_B2ps_v2"          # VM size for nodes (Standard_B2ps_v2)
LOCATION="southeastasia"            # Azure region for the cluster
K8S_VERSION="1.31.6"                # Kubernetes version
ADMIN_GROUP_NAME="AKSAdmins"        # Name of the admin group for RBAC
ADMIN_USER_EMAIL=""                 # Email of the admin user (to be filled)

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "Checking prerequisites..."

# Check if Azure CLI is installed
if ! command_exists az; then
    echo "Azure CLI is not installed. Please install it first."
    echo "Visit: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if kubectl is installed
if ! command_exists kubectl; then
    echo "kubectl is not installed. Please install it first."
    echo "Visit: https://kubernetes.io/docs/tasks/tools/install-kubectl/"
    exit 1
fi

# Check if user is logged in to Azure
if ! az account show > /dev/null; then
    echo "Please log in to Azure first using: az login"
    exit 1
fi

# Get current user's email for admin group
if [ -z "$ADMIN_USER_EMAIL" ]; then
    ADMIN_USER_EMAIL=$(az account show --query user.name -o tsv)
    echo "Using current user email as admin: $ADMIN_USER_EMAIL"
fi

# Check if the Resource Group exists
echo "Checking if the resource group $RESOURCE_GROUP exists..."

az group show --name $RESOURCE_GROUP &>/dev/null

if [ $? -ne 0 ]; then
    echo "Resource group $RESOURCE_GROUP does not exist. Creating resource group..."
    # Create the resource group if it doesn't exist
    az group create --name $RESOURCE_GROUP --location $LOCATION
else
    echo "Resource group $RESOURCE_GROUP already exists."
fi

# Create Microsoft Entra ID admin group if it doesn't exist
echo "Creating Microsoft Entra ID admin group..."
ADMIN_GROUP_ID=$(az ad group create --display-name $ADMIN_GROUP_NAME --mail-nickname $ADMIN_GROUP_NAME --query id -o tsv)
if [ $? -ne 0 ]; then
    echo "Failed to create admin group. Please check your permissions."
    exit 1
fi

# Add current user to the admin group
echo "Adding user to admin group..."
az ad group member add --group $ADMIN_GROUP_ID --member-id $(az ad user show --id $ADMIN_USER_EMAIL --query id -o tsv)

# Create the AKS cluster with Microsoft Entra ID integration
echo "Creating AKS cluster with name: $CLUSTER_NAME in resource group: $RESOURCE_GROUP"

az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $CLUSTER_NAME \
    --node-count $NODE_COUNT \
    --enable-azure-rbac \
    --aad-admin-group-object-ids $ADMIN_GROUP_ID \
    --generate-ssh-keys \
    --node-vm-size $VM_SIZE \
    --location $LOCATION \
    --kubernetes-version $K8S_VERSION \
    --network-plugin azure \
    --network-policy azure \
    --enable-managed-identity \
    --enable-cluster-autoscaler \
    --min-count 1 \
    --max-count 2

# Check if cluster creation was successful
if [ $? -ne 0 ]; then
    echo "Failed to create AKS cluster. Please check the error message above."
    exit 1
fi

# Verify the AKS Cluster and Node Pool
echo "Verifying the AKS cluster and node pool..."
az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --output table

# Get cluster credentials
echo "Setting up kubectl context for the cluster..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME

# Verify cluster access
echo "Verifying cluster access..."
kubectl get nodes

# Print important information
echo "==============================================="
echo "AKS Cluster setup completed successfully!"
echo "==============================================="
echo "Cluster Name: $CLUSTER_NAME"
echo "Resource Group: $RESOURCE_GROUP"
echo "Admin Group: $ADMIN_GROUP_NAME"
echo "Admin User: $ADMIN_USER_EMAIL"
echo "==============================================="
echo "To access the cluster dashboard, run:"
echo "az aks browse --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME"
echo "==============================================="

