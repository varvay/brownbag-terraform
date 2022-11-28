variable "aws_provider_configuration" {
  type = object({
    region = string
    access_key = string
    secret_key = string
  })
  sensitive = true
  nullable = false
  description = "AWS provider configuration"
}

variable "environment" {
  type = string
  default = "dev"
  nullable = false
  description = "Terraform application destination e.g. dev, staging, prod"
}