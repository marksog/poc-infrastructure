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

