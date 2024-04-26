# Create vpc
resource "aws_vpc" "production-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

# Create public subnets
resource "aws_subnet" "public-subnet-az-1" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.public-subnet-az-1-cidr
  availability_zone = "us-east-1"

  tags = {
    Name = "public-subnet-az-1"
  }
}

resource "aws_subnet" "public-subnet-az-2" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.public-subnet-az-2-cidr
  availability_zone = "us-east-2"

  tags = {
    Name = "public-subnet-az-2"
  }
}


resource "aws_subnet" "private-app-subnet-az-1" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.private-app-subnet-az-1-cidr
  availability_zone = "us-east-3"

  tags = {
    Name = "private-app-subnet-az-1"
  }
}

# Create private subnets
resource "aws_subnet" "private-app-subnet-az-2" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.private-app-subnet-az-2-cidr
  availability_zone = "us-east-1"

  tags = {
    Name = "private-app-subnet-az-2"
  }
}

resource "aws_subnet" "private-data-subnet-az-1" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.private-data-subnet-az-1-cidr
  availability_zone = "us-east-2"

  tags = {
    Name = "private-data-subnet-az-1"
  }
}


resource "aws_subnet" "private-data-subnet-az-2" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = var.private-data-subnet-az-2-cidr
  availability_zone = "us-east-3"

  tags = {
    Name = "private-data-subnet-az-2"
  }
}

#create route table
resource "aws_route_table" "public-route-table-az-1" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "public-route-table-az-1"
  }
}

resource "aws_route_table" "public-route-table-az-2" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "private-route-table-az-2"
  }

}

# Create route table associate
resource "aws_route_table_association" "public-route-association-az-1" {
  subnet_id      = aws_subnet.public-subnet-az-1.id
  route_table_id = aws_route_table.public-route-table-az-1.id
}


resource "aws_route_table_association" "public-route-association-az-2" {
  subnet_id      = aws_subnet.public-subnet-az-2.id
  route_table_id = aws_route_table.public-route-table-az-1.id
}




# create elastic ip for nat gateway and assign private
resource "aws_eip" "eip-for-az-1" {
  domain = "vpc"

  tags = {
    Name = "eip-az-1"
  }
}

resource "aws_eip" "eip-for-az-2" {
  domain = "vpc"

  tags = {
    Name = "eip-az-2"
  }
}

# Create a nat gateway in the 2 availability zone
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip-for-az-1.id
  subnet_id     = aws_subnet.public-subnet-az-1.id

  tags = {
    Name = "Prod-NGW1"
  }
  depends_on = [aws_internet_gateway.igw-production]
}


resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip-for-az-2.id
  subnet_id     = aws_subnet.public-subnet-az-2.id

  tags = {
    Name = "Prod-NGW2"
  }

  depends_on = [aws_internet_gateway.igw-production]
}


resource "aws_internet_gateway" "igw-production" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "Production_internet_gateway"
  }
}

# create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.production-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }

  tags = {
    Name = "Private route az 1"
  }
}


resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.production-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }

  tags = {
    Name = "Private route az 2"
  }
}




