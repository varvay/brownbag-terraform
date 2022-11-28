terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.41.0"
    }
  }
}

provider "aws" {
  region     = var.aws_provider_configuration.region
  access_key = var.aws_provider_configuration.access_key
  secret_key = var.aws_provider_configuration.secret_key
}

module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
}

module "backend_server" {
  source = "./modules/backendServer"
  subnet_ids = module.vpc.subnet_ids
  security_group_id = module.vpc.security_group_id
  environment = var.environment
}

module "database" {
  source = "./modules/database"
  subnet_id = module.vpc.subnet_ids[0]
  security_group_id = module.vpc.security_group_id
  environment = var.environment
}

output "name" {
  value = module.vpc.subnet_ids
}