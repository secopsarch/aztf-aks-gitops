# Linux Sandbox Environment

This example demonstrates how to create a sandbox environment with multiple Linux VMs (2 Ubuntu and 1 RedHat) using Terraform and configure them using Ansible.

## Infrastructure Components

1. **Virtual Machines**
   - 2 Ubuntu 18.04 LTS VMs
   - 1 RedHat 8 VM
   - Standard_B1s VM size (low cost)
   - Public IP addresses for SSH access

2. **Networking**
   - Virtual Network
   - Subnet
   - Network Security Group with SSH access
   - Public IPs for each VM

3. **Ansible Configuration**
   - Common system configuration
   - OS-specific package installation
   - Security hardening
   - Docker installation
   - Development tools

## Prerequisites

- Azure CLI installed
- Terraform >= 1.0.0
- Ansible >= 2.9.0
- SSH key pair
- Azure subscription with appropriate permissions

## Usage

1. **Initialize Terraform**
   ```bash
   cd examples/linux-sandbox
   terraform init
   ```

2. **Create terraform.tfvars**
   ```hcl
   resource_group_name = "your-resource-group"
   location           = "eastus"
   ssh_public_key     = "your-ssh-public-key"
   ```

3. **Apply Terraform Configuration**
   ```bash
   terraform plan
   terraform apply
   ```

4. **Configure Ansible**
   ```bash
   cd ansible
   # Update inventory.yml with VM IPs from terraform output
   ```

5. **Run Ansible Playbooks**
   ```bash
   ansible-playbook -i inventory.yml playbooks/site.yml
   ```

## Ansible Playbooks

1. **common.yml**
   - System updates
   - Timezone configuration
   - NTP setup
   - Security hardening (fail2ban, UFW)
   - Common packages

2. **ubuntu.yml**
   - Ubuntu-specific packages
   - Docker installation
   - Development tools

3. **redhat.yml**
   - RedHat-specific packages
   - EPEL repository
   - Docker installation
   - Development tools

## Security Features

1. **Network Security**
   - SSH-only access
   - UFW firewall
   - fail2ban for brute force protection

2. **System Security**
   - Regular updates
   - Secure time synchronization
   - Limited package installation

## Cost Optimization

- Using Standard_B1s VM size (low cost)
- Dynamic public IPs
- Standard storage for OS disks

## Troubleshooting

1. **SSH Access**
   ```bash
   ssh -i ~/.ssh/id_rsa adminuser@<vm-public-ip>
   ```

2. **Ansible Connection**
   ```bash
   ansible -i inventory.yml all -m ping
   ```

3. **Docker Verification**
   ```bash
   docker --version
   docker-compose --version
   ```

## Contributing

Please read [CONTRIBUTING.md](../../CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](../../LICENSE) file for details. 