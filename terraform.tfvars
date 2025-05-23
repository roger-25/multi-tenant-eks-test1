# Generic Variables
vpc_name                    = "eks-test"
vpc_cidr_block              = "10.0.0.0/16"
public_subnets              = ["10.0.0.0/20","10.0.16.0/20"]
public_subnet_ids           = ["subnet-052d662bfe39cacd4","subnet-0c81521416a5591a4"]
cluster_name                = "terraform-eks-test"
aws_region                  = "us-east-1"
region                      = "us-east-1"
image_url                   = "746669234841.dkr.ecr.us-east-1.amazonaws.com/roger-repo"
acm_certificate_arn         = "arn:aws:acm:us-east-1:746669234841:certificate/43e6fef7-bff9-4016-a455-6136e78cdccc"
domain_name                 = "rogeralex.work.gd"
aws_acm_certificate         = "43e6fef7-bff9-4016-a455-6136e78cdccc"
route53_zone_id             = "Z08192452QHP1YWWZQNLR"
security_group_id           = "sg-08cfd2268b6ec324e"    