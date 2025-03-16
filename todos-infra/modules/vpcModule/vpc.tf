resource "aws_vpc" "main" { 
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  selected_azs = slice(data.aws_availability_zones.available.names, 0, 3)
  newbits      = 8  # Creates /24 subnets from /16 VPC
  cidr_blocks  = [for i in range(length(local.selected_azs)) :
    cidrsubnet(var.vpc_cidr, local.newbits, i)
  ]
}

resource "aws_subnet" "public" {
  for_each          = tomap({ for idx, az in local.selected_azs : idx => az })
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.cidr_blocks[tonumber(each.key)]
  availability_zone = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${each.value}"
  }
  
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each      = aws_subnet.public
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public.id
}
