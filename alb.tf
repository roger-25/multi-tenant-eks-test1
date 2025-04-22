resource "aws_lb" "tenant_alb" {
  name               = "alb-${var.tenant_name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group
}