locals {
  tags = {
    "project" = "brownbag"
    "environment" = var.environment
  }
  subnets = {
    us-east-1a = "172.0.0.0/20"
    us-east-1b = "172.0.16.0/20"
    us-east-1c = "172.0.32.0/20"
    us-east-1d = "172.0.48.0/20"
    us-east-1e = "172.0.64.0/20"
    us-east-1f = "172.0.80.0/20"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "172.0.0.0/16"
  enable_network_address_usage_metrics = true
  tags = local.tags

  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnets" {
  for_each = local.subnets
  availability_zone = each.key
  cidr_block = each.value
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.vpc.id
  tags = local.tags
}

resource "aws_security_group" "security_group" {
  name_prefix = "brownbag"
  vpc_id = aws_vpc.vpc.id
  tags = local.tags
}

resource "aws_security_group_rule" "security_group_ingress_allow_all" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "security_group_egress_allow_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = local.tags
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = local.tags
}

output "subnet_ids" {
  value = [for subnet in aws_subnet.subnets : subnet.id]
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}