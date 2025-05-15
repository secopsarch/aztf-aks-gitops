# Infrastructure Documentation

## Overview
This project uses a simple AWS ECS Fargate setup to deploy a containerized web application.

## Infrastructure Components

### Network Layer
- VPC with public subnets
- Internet Gateway for public access
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

## Deployment Process

1. **Local Setup**
   - Run `scripts/setup.sh` to create:
     - S3 bucket for Terraform state
     - DynamoDB table for state locking
     - ECR repository for container images

2. **GitLab Setup**
   Configure the following variables in GitLab CI/CD settings:
   ```
   AWS_ACCESS_KEY_ID
   AWS_SECRET_ACCESS_KEY
   AWS_DEFAULT_REGION=us-west-2
   AWS_ACCOUNT_ID
   CI_ENVIRONMENT_NAME=dev
   ```

3. **Deployment Flow**
   - Push to main branch triggers:
     - Application testing
     - Container build and push to ECR
     - Terraform plan generation
     - Infrastructure deployment
   
4. **State Management**
   - Terraform state in S3: `legacy-app-terraform-state`
   - State locking: DynamoDB table `terraform-state-lock`
   - Environment separation: dev/prod state files

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
