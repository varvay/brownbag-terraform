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
  name_prefix = "brownbag-database"
  disable_api_stop = false
  ebs_optimized = false
  hibernation_options {
    configured = false
  }
  image_id = "ami-05723c3b9cf4bf4ff"
  instance_type = "t2.micro"
  key_name = "brownbag-database"
  monitoring {
    enabled = true
  }
  update_default_version = true
  tags = local.tags
  network_interfaces {
    delete_on_termination = true
    subnet_id = var.subnet_id
    security_groups = [ var.security_group_id ]
  }
  dynamic "tag_specifications" {
    for_each = local.launch_template_resource_tags
    content {
      resource_type = tag_specifications.key
      tags = tag_specifications.value
    }
  }
  user_data = filebase64("${path.module}/userData/database-postgresql-install.sh")
}

resource "aws_instance" "instance" {
  associate_public_ip_address = true
  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  tags = local.tags
}