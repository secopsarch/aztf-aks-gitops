#!/bin/bash

# Variables
RESOURCE_GROUP="akslab01"           # Resource group name
CLUSTER_NAME="test-aks01"           # AKS cluster name
ADMIN_GROUP_NAME="AKSAdmins"        # Name of the admin group for RBAC

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

# Check if user is logged in to Azure
if ! az account show > /dev/null; then
    echo "Please log in to Azure first using: az login"
    exit 1
fi

# Function to confirm deletion
confirm_deletion() {
    read -p "Are you sure you want to delete the resource group '$RESOURCE_GROUP' and all its resources? This action cannot be undone. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 1
    fi
}

# Function to check if resource group exists
check_resource_group() {
    if ! az group show --name $RESOURCE_GROUP &>/dev/null; then
        echo "Resource group '$RESOURCE_GROUP' does not exist."
        exit 1
    fi
}

# Function to check if AKS cluster exists
check_aks_cluster() {
    if ! az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME &>/dev/null; then
        echo "AKS cluster '$CLUSTER_NAME' does not exist in resource group '$RESOURCE_GROUP'."
        exit 1
    fi
}

# Function to remove kubectl context
remove_kubectl_context() {
    echo "Removing kubectl context for cluster..."
    kubectl config delete-context $CLUSTER_NAME || true
}

# Function to delete Microsoft Entra ID group
delete_ad_group() {
    echo "Deleting Microsoft Entra ID admin group..."
    GROUP_ID=$(az ad group list --display-name $ADMIN_GROUP_NAME --query '[0].id' -o tsv)
    if [ ! -z "$GROUP_ID" ]; then
        az ad group delete --group $GROUP_ID
        echo "Microsoft Entra ID group deleted successfully."
    else
        echo "Microsoft Entra ID group not found."
    fi
}

# Main execution
echo "Starting cleanup process..."

# Check if resources exist
check_resource_group
check_aks_cluster

# Confirm deletion
confirm_deletion

# Remove kubectl context
remove_kubectl_context

# Delete AKS cluster
echo "Deleting AKS cluster '$CLUSTER_NAME'..."
az aks delete --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --yes --no-wait

# Wait for cluster deletion
echo "Waiting for cluster deletion to complete..."
az aks wait --deleted --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME

# Delete Microsoft Entra ID group
delete_ad_group

# Delete resource group and all remaining resources
echo "Deleting resource group '$RESOURCE_GROUP' and all remaining resources..."
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Wait for resource group deletion
echo "Waiting for resource group deletion to complete..."
az group wait --deleted --name $RESOURCE_GROUP

echo "==============================================="
echo "Cleanup completed successfully!"
echo "==============================================="
echo "The following resources have been deleted:"
echo "- AKS Cluster: $CLUSTER_NAME"
echo "- Resource Group: $RESOURCE_GROUP"
echo "- Microsoft Entra ID Group: $ADMIN_GROUP_NAME"
echo "===============================================" 