variable "environment" {
  type = string
  default = "dev"
  nullable = false
  description = "Terraform application destination e.g. dev, staging, prod"
}