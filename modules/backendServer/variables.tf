variable "environment" {
  type = string
  default = "dev"
  nullable = false
}

variable "security_group_id" {
  type = string
  nullable = false
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
}
