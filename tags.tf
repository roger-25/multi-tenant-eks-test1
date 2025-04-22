resource "aws_ec2_tag" "internal_elb_role" {
  for_each    = toset(var.alb_public_subnet_ids)
  resource_id = each.key
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "eks_cluster_tag" {
  for_each    = toset(var.alb_public_subnet_ids)
  resource_id = each.key
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "owned"
}
