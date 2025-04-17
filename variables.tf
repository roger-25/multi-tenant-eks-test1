# Input Variables
variable "tenant_name" {}

# AWS Region
variable "aws_region" {}

# EKS Cluster Input Variables
variable "cluster_name" {}

# VPC Input Variables
variable "vpc_name"{}

variable "tenant_env" {}

variable "region" {}

# VPC CIDR Block
variable "vpc_cidr_block" {}

# VPC Public Subnets
variable "vpc_public_subnets" {}

variable "vpc_private_subnets" {}

variable "image_url" {}

variable "domain_name" {}

variable "acm_certificate_arn" {}

variable "alb_public_subnet_ids" {}

