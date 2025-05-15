terraform {
  backend "s3" {
    bucket         = "legacy-app-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

module "ecs" {
  source = "../../modules/ecs"

  aws_region       = var.aws_region
  project_name     = "legacy-app"
  environment      = var.environment
  container_image  = var.container_image
  
  # Development settings
  task_cpu        = 256
  task_memory     = 512
  desired_count   = 1

  # Optional overrides
  container_port  = 80
  health_check_path = "/health"
}

terraform {
  backend "s3" {
    bucket = "gitlab-devsecops-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}
