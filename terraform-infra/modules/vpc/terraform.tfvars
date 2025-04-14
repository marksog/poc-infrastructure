aws_region = "us-east-1"
vpc_cidr  = "10.10.0.0/16"
public_subnet_cidrs = "10.10.1.0/24"
private_subnet_buck_cidrs = "10.10.2.0/24"
private_subnet_app_cidrs = "10.10.3.0/24"
tags = {
    Name = "Development-Infra"
    Environment = "Development"
    Project = "Terraform VPC Module"
    CostCenter = "DevOps"
    Owner = "DevOps Team"
    CreatedBy = "Terraform"
}

az_private_subnet_buck = "us-east-1a"
az_private_subnet_app = "us-east-1b"
az_public_subnet = "us-east-1a"
enable_nat_gateway = true