module "ecs" {
  source = "../../modules/ecs"

  aws_region            = "us-west-2"
  project_name          = "gitlab-devsecops"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  task_cpu             = 256
  task_memory          = 512
  container_image      = "registry.gitlab.com/your-project/your-image:latest"
  container_port       = 80
  service_desired_count = 1
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
