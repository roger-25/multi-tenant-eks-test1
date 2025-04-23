resource "aws_lb" "tenant_alb" {
  name               = "alb-${var.tenant_name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.alb_public_subnet_ids
  security_groups    = [var.security_group_id]

  tags = {
    Name    = "alb-${var.tenant_name}"
    Tenant  = var.tenant_name
    Env     = var.environment
  }
}