# Infrastructure Documentation

## Overview
This directory contains the Terraform infrastructure code for deploying our application to AWS ECS Fargate using GitOps principles.

## Infrastructure Components

### Network Layer
- VPC with public and private subnets
- Internet Gateway for public subnets
- NAT Gateway for private subnet outbound traffic
- Route tables for subnet traffic management

### Container Infrastructure
- ECS Fargate Cluster
- ECS Task Definition
- ECS Service
- Application Load Balancer
- Target Groups
- Auto Scaling Policies

### Security
- Security Groups
- IAM Roles and Policies
- AWS KMS Encryption
- VPC Endpoints for secure AWS service access

## Environment Configuration

### Development Environment
Located in `environments/dev`:
- Smaller instance sizes
- Reduced redundancy
- Debug logging enabled
- Single AZ deployment

### Production Environment
Located in `environments/prod`:
- Production-grade instance sizes
- High availability setup
- Multi-AZ deployment
- Enhanced monitoring

## GitOps Workflow

1. Infrastructure changes are proposed via merge requests
2. Terraform plan is automatically generated and added to the MR
3. Approval required for infrastructure changes
4. Automatic apply on merge to main branch
5. State stored in S3 with DynamoDB locking

## Prerequisites

- AWS Account with appropriate permissions
- Terraform 1.0+
- AWS CLI configured
- GitLab CI/CD variables set:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_DEFAULT_REGION`
  - `TF_STATE_BUCKET`
  - `TF_LOCK_TABLE`

## Usage

### Local Development
```bash
# Initialize Terraform
cd environments/dev
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply
```

### GitLab CI/CD Pipeline
The infrastructure is automatically managed through the GitLab CI/CD pipeline:
1. `terraform_plan` job generates plans for review
2. `terraform_apply` job applies approved changes
3. State is stored in S3 with locking via DynamoDB
