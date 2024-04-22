# Create vpc
resource "aws_vpc" "production-vpc" {
    cidr_block       = "${var.vpc_cidr}" 
    instance_tenancy = "default"
    enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

# Create public subnets
resource "aws_subnet" "public-subnet-az-1" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.public-subnet-az-1-cidr}"
  availability_zone = "us-east-1"

  tags = {
    Name = "public-subnet-az-1"
  }
}

resource "aws_subnet" "public-subnet-az-2" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.public-subnet-az-2-cidr}"
  availability_zone = "us-east-2"

  tags = {
    Name = "public-subnet-az-2"
  }
}


resource "aws_subnet" "public-subnet-az-3" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.public-subnet-az-3-cidr}"
  availability_zone = "us-east-3"

  tags = {
    Name = "public-subnet-az-3"
  }
}

# Create private subnets
resource "aws_subnet" "private-subnet-az-1" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.private-subnet-az-1-cidr}"
  availability_zone = "us-east-1"

  tags = {
    Name = "private-subnet-az-1"
  }
}

resource "aws_subnet" "private-subnet-az-2" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.private-subnet-az-2-cidr}"
  availability_zone = "us-east-2"

  tags = {
    Name = "private-subnet-az-2"
  }
}


resource "aws_subnet" "private-subnet-az-3" {
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = "${var.private-subnet-az-3-cidr}"
  availability_zone = "us-east-3"

  tags = {
    Name = "private-subnet-az-3"
  }
}


#create route table

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "private-route-table"
  }
  
}

resource "aws_route_table_association" "public-route-association" {  
  subnet_id      = [aws_subnet.public-subnet-az-1.id, aws_subnet.public-subnet-az-1.id, aws_subnet.public-subnet-az-1.id]
  route_table_id = aws_route_table.public-route-table.id
  
}