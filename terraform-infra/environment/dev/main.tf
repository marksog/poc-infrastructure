

###############################
# 1. VPC 
###############################

module "network" {
  source = "../../modules/vpc" # Adjust the path if needed
  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr

  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_buck_cidrs = var.private_subnet_buck_cidrs
  private_subnet_app_cidrs = var.private_subnet_app_cidrs

  tags = var.tags
  az_public_subnet = var.az_public_subnet
  az_private_subnet_buck = var.az_private_subnet_buck
  az_private_subnet_app  = var.az_private_subnet_app
}