#!/bin/bash

# Create S3 bucket for Terraform state
aws s3 mb s3://legacy-app-terraform-state --region us-west-2

# Enable versioning for state bucket
aws s3api put-bucket-versioning \
    --bucket legacy-app-terraform-state \
    --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
    --table-name terraform-state-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region us-west-2

# Create ECR repository
aws ecr create-repository \
    --repository-name legacy-app \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=AES256 \
    --region us-west-2
