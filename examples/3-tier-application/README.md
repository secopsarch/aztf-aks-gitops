# Azure Three-Tier Application Infrastructure

This project implements a three-tier application architecture on Azure using Terraform. The architecture consists of web, application, and database tiers with proper network segmentation and security controls.

## Architecture Overview

```
                                     ┌──────────────────┐
                                     │                  │
                                     │  Azure Container │
                                     │    Registry      │
                                     │                  │
                                     └──────────────────┘
                                             ▲
                                             │
┌──────────────────┐                        │
│                  │                ┌────────┴───────┐
│   Application    │                │                │
│    Gateway       │◄───────────────┤   AKS Cluster │
│   (WAF v2)       │                │                │
│                  │                └────────┬───────┘
└──────────────────┘                        │
         ▲                                  │
         │                                  ▼
         │                         ┌──────────────────┐
         │                         │                  │
         └─────────────────────────┤  MySQL Flexible │
                                  │    Server        │
                                  │                  │
                                  └──────────────────┘

```

## Components

1. **Network Module (`network`)**
   - Virtual Network with three subnets:
     - Web Subnet (Application Gateway)
     - App Subnet (AKS)
     - DB Subnet (MySQL)
   - Network Security Groups
   - Route Tables

2. **Application Gateway Module (`appgateway`)**
   - WAF v2 SKU
   - Public IP
   - HTTP Listeners
   - Backend Pools
   - Health Probes

3. **AKS Module (`aks`)**
   - Managed Kubernetes Cluster
   - System and User Node Pools
   - Auto-scaling Configuration
   - Network Integration

4. **MySQL Module (`mysql`)**
   - Azure Database for MySQL Flexible Server
   - Private Endpoint Connection
   - Firewall Rules
   - Database Configuration

5. **Private DNS Module (`private_dns`)**
   - Private DNS Zone for MySQL
   - Virtual Network Links
   - A Records

6. **ACR Module (`acr`)**
   - Azure Container Registry
   - Premium SKU
   - Admin Access

## Network Security

- Each tier is isolated in its own subnet
- Private endpoints for database access
- Application Gateway WAF protection
- Network Security Groups with proper rules
- Private DNS resolution

## Prerequisites

1. Azure Subscription
2. Azure CLI installed
3. Terraform installed (v1.0.0+)
4. Proper Azure permissions

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## Variables

Key variables that need to be configured:

- `resource_group_name`: Name of the resource group
- `location`: Azure region
- `environment`: Environment name (e.g., dev, prod)
- `address_space`: VNet address space
- `mysql_administrator_password`: MySQL admin password
- `kubernetes_version`: AKS version

## Outputs

- `aks_cluster_name`: Name of the AKS cluster
- `acr_login_server`: ACR login server URL
- `mysql_server_fqdn`: MySQL server FQDN
- `application_gateway_ip`: Application Gateway public IP

## Security Considerations

1. Network Security:
   - Subnets are isolated
   - NSGs control traffic flow
   - Private endpoints for services

2. Access Control:
   - RBAC enabled on AKS
   - MySQL uses private endpoints
   - ACR with admin access disabled

3. Monitoring:
   - Azure Monitor integration
   - Log Analytics workspace
   - Container insights

## Cost Optimization

- Auto-scaling enabled for AKS
- Proper SKU selection for services
- Resource tagging for cost allocation

## Maintenance

1. Regular Updates:
   - AKS version upgrades
   - Security patches
   - Infrastructure updates

2. Backup Strategy:
   - MySQL automated backups
   - AKS state backup
   - Infrastructure state backup

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

This project is licensed under the MIT License. 