module "ecs" {
  source = "../../modules/ecs"

  aws_region            = "us-west-2"
  project_name          = "gitlab-devsecops"
  environment          = "prod"
  vpc_cidr             = "10.1.0.0/16"
  task_cpu             = 1024
  task_memory          = 2048
  container_image      = "registry.gitlab.com/your-project/your-image:latest"
  container_port       = 80
  service_desired_count = 2
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
