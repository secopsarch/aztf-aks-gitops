module "ecs" {
  source = "../../modules/ecs"

  aws_region           = "us-west-2"
  project_name         = "legacy-app"
  environment          = "prod"
  vpc_cidr            = "10.0.0.0/16"
  container_image     = var.container_image  # From GitLab pipeline
  container_port      = 80
  
  # Production settings
  task_cpu            = 1024
  task_memory         = 2048
  min_capacity        = 2
  max_capacity        = 4
  
  # Tags
  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
    Project     = "legacy-app"
  }
}

terraform {
  backend "s3" {
    bucket = "gitlab-devsecops-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}
