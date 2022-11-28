locals {
  tags = {
    "project" = "brownbag"
    "environment" = var.environment
  }
  launch_template_resource_tags = {
    instance = local.tags
    volume = local.tags
    network-interface = local.tags
  }
}

resource "aws_launch_template" "launch_template" {
  name_prefix = "brownbag-backend-server"
  disable_api_stop = false
  ebs_optimized = false
  hibernation_options {
    configured = false
  }
  image_id = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name = "brownbag-backend-server"
  monitoring {
    enabled = true
  }
  update_default_version = true
  tags = local.tags
  vpc_security_group_ids = [ var.security_group_id ]
  dynamic "tag_specifications" {
    for_each = local.launch_template_resource_tags
    content {
      resource_type = tag_specifications.key
      tags = tag_specifications.value
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name_prefix = "brownbag-backend-server"
  vpc_zone_identifier = var.subnet_ids
  max_size = 1
  min_size = 0
  desired_capacity = 1
  capacity_rebalance = true
  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  protect_from_scale_in = false
  dynamic "tag" {
    for_each = local.tags
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}