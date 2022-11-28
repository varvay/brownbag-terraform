variable "environment" {
  type = string
  default = "dev"
  nullable = false
  description = "Terraform application destination e.g. dev, staging, prod"
}

variable "subnet_id" {
  type = string
  nullable = false
  description = "Backend server AWS deployment destination subnet's IDs"
}

variable "security_group_id" {
  type = string
  nullable = false
  description = "Backend server AWS security group's ID"
}
