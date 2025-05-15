# Legacy App Containerization & GitOps Pipeline

## Overview
This document outlines our approach to containerizing and deploying a legacy application using GitLab CI/CD and GitOps practices.

## Pipeline Stages and Tools

### 1. Test Stage
The test stage includes basic code quality checks and testing:

| Tool | Purpose |
|------|---------|
| HTMLHint | HTML code quality checking |
| Jest | JavaScript unit testing |

```yaml
test:
  - HTML linting
  - Unit tests
```

### 2. Build Stage
| Tool | Purpose |
|------|---------|
| Docker | Building and pushing container images |

```yaml
build:
  - Docker image building
  - Image tagging
  - Push to registry
```

### 3. Deploy Stage
| Tool | Purpose |
|------|---------|
| AWS CLI | Deploying to ECS Fargate |

```yaml
deploy:
  - ECS service update
  - Health checks
```

## Required Variables

### GitLab CI/CD Variables
```yaml
# Required Variables
- CI_REGISTRY_USER        # GitLab registry username
- CI_REGISTRY_PASSWORD    # GitLab registry password
- AWS_ACCESS_KEY_ID      # AWS access key
- AWS_SECRET_ACCESS_KEY  # AWS secret key
- AWS_DEFAULT_REGION     # AWS region (e.g., us-west-2)
- ECS_CLUSTER_NAME       # Name of your ECS cluster
- ECS_SERVICE_NAME       # Name of your ECS service
```

## Deployment Strategy

### Simple Deployment Flow
1. Code changes pushed to main branch
2. Basic tests run (HTML lint and unit tests)
3. Docker image built and pushed
4. ECS service updated with new image

### Deployment Process
1. Build and tag Docker image
2. Push image to GitLab registry
3. Update ECS service
4. ECS handles rolling deployment

### Monitoring
- ECS service health checks
- Application Load Balancer health checks
- CloudWatch basic metrics

## Troubleshooting

### Common Issues
1. Pipeline failures
   - Check test logs
   - Verify Docker build steps
   - Check AWS credentials
2. Deployment issues
   - Check ECS service events
   - Verify container health checks
   - Check task definition

## Pipeline Configuration

### Required Variables
```yaml
GitLab CI/CD Variables:
- CI_REGISTRY_USER
- CI_REGISTRY_PASSWORD
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_DEFAULT_REGION
- TF_STATE_BUCKET
- TF_LOCK_TABLE
```

### Environment Specific Variables
```yaml
Development:
- TF_VAR_environment=dev
- TF_VAR_instance_type=t3.small

Production:
- TF_VAR_environment=prod
- TF_VAR_instance_type=t3.medium
```

## Deployment Strategy

### GitOps Workflow
1. Code changes pushed to feature branch
2. Pipeline runs all tests and scans
3. Merge request created
4. Infrastructure plan generated
5. Review and approval
6. Merge triggers deployment

### Deployment Process
1. Build and tag Docker image
2. Update infrastructure if needed
3. Deploy new container version
4. Health check validation
5. Traffic cutover

### Rollback Process
1. Automatic rollback on failed health checks
2. Manual rollback capability
3. State preservation
4. Log collection for debugging

## Monitoring & Logging

### Pipeline Metrics
- Build duration
- Test coverage
- Security scan results
- Deployment success rate

### Application Metrics
- Response times
- Error rates
- Resource utilization
- User activity

## Troubleshooting

### Common Issues
1. Pipeline failures
2. Security scan blocks
3. Infrastructure drift
4. Deployment failures

### Resolution Steps
1. Check pipeline logs
2. Verify security scan reports
3. Compare terraform plans
4. Review ECS task logs
