variable "environment" {
  type = string
  default = "dev"
  nullable = false
  description = "Terraform application destination e.g. dev, staging, prod"
}

variable "security_group_id" {
  type = string
  nullable = false
  description = "Backend server AWS security group's ID"
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
  description = "Backend server AWS deployment destination subnet's IDs"
}
