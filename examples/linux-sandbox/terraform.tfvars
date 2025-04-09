# Resource Group and Location
resource_group_name = "ansible-learn"
location            = "eastus"

# Environment and Naming
environment = "sandbox"
prefix      = "ansibledemo"

# Network Configuration
address_space   = ["10.0.0.0/16"]
subnet_prefixes = ["10.0.1.0/24"]

# VM Configuration
vm_size        = "Standard_B1s" # Low cost VM size
admin_username = "adminuser"
ssh_public_key = "/home/devops/repolist/aztf-aks-gitops/examples/linux-sandbox/ssh-keys/id_rsa.pub"

