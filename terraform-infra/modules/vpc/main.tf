resource "aws_vpc" "finops_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  tags = var.tags
}

# creating pulic subnet 
resource "aws_subnet" "public_facing_subnet" {
  vpc_id = aws_vpc.finops_vpc.id
  cidr_block = var.public_subnet_cidrs
  availability_zone = var.az_public_subnet
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - Public Subnet"
      Type = "Public"
    }
  )
}

# creating IGW
resource "aws_internet_gateway" "finops_igw" {
  vpc_id = aws_vpc.finops_vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - Internet Gateway"
    }
  )
}

# creating route table
resource "aws_route_table" "finops_pub_rt" {
  vpc_id = aws_vpc.finops_vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - Public Route Table"
    }
  )
}

resource "aws_route_table_association" "pub_rta" {
  subnet_id = aws_subnet.public_facing_subnet.id
  route_table_id = aws_route_table.finops_pub_rt.id
}

# routing public to internet
resource "aws_route" "internet_access" {
  route_table_id = aws_route_table.finops_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.finops_igw.id
}

# Nat gateway
resource "aws_eip" "nat_eip" {
  depends_on = [ aws_internet_gateway.finops_igw ]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_facing_subnet.id
  depends_on = [ aws_internet_gateway.finops_igw ]
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - NAT Gateway"
    }
  )
}

resource "aws_subnet" "private_app_subnet" {
  vpc_id = aws_vpc.finops_vpc.id
  cidr_block = var.private_subnet_app_cidrs
  availability_zone = var.az_private_subnet_app
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - Private App Subnet"
      Type = "Private"
    }
  )
}

resource "aws_route_table" "private_app_rt" {
  vpc_id = aws_vpc.finops_vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]} - Private App Route Table"
    }
  )
}

resource "aws_route_table_association" "app_assoc_rt" {
    route_table_id = aws_route_table.private_app_rt.id
    subnet_id = aws_subnet.private_app_subnet.id
}

# if Nat is enabled use nat gateway
resource "aws_route" "app_route_priv" {
    count = var.enable_nat_gateway ? 1 : 0
    route_table_id = aws_route_table.private_app_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
    depends_on = [ aws_nat_gateway.nat_gw ]
}

resource "aws_subnet" "private_data_subnet" {
    vpc_id = aws_vpc.finops_vpc.id
    cidr_block = var.private_subnet_buck_cidrs
    availability_zone = var.az_private_subnet_buck
    tags = merge(
        var.tags,
        {
        Name = "${var.tags["Name"]} - Private Data Subnet"
        Type = "Private"
        }
    )
}

resource "aws_route_table" "private_data_rt" {
    vpc_id = aws_vpc.finops_vpc.id
    tags = merge(
        var.tags,
        {
        Name = "${var.tags["Name"]} - Private Data Route Table"
        }
    )
}

resource "aws_route_table_association" "data_assoc_rt" {
    route_table_id = aws_route_table.private_data_rt.id
    subnet_id = aws_subnet.private_data_subnet.id
}

# if Nat is enabled use nat gateway
resource "aws_route" "priv_data_route" {
    count = var.enable_nat_gateway ? 1 : 0
    route_table_id = aws_route_table.private_data_rt.id 
    destination_cidr_block = "0.0.0.0/24"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
    depends_on = [ aws_nat_gateway.nat_gw ]
}