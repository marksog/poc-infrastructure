variable "aws_region" {
  description = "The AWS region to create the VPC in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = string
}

variable "private_subnet_buck_cidrs" {
  description = "The CIDR blocks for the private data storage subnets"
  type        = string
}

variable "private_subnet_app_cidrs" {
  description = "The CIDR blocks for the private application subnets"
  type        = string
}

variable "az_public_subnet" {
  description = "The availability zones for the public subnets"
  type        = string
}

variable "az_private_subnet_buck" {
  description = "The availability zones for the private data storage subnets"
  type        = string
}

variable "az_private_subnet_app" {
  description = "The availability zones for the private application subnets"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the VPC and its resources"
  type        = map(string)
  default     = {} 
}