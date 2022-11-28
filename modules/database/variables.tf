variable "environment" {
  type = string
  default = "dev"
  nullable = false
}

variable "subnet_id" {
  type = string
  nullable = false
}

variable "security_group_id" {
  type = string
  nullable = false
}
