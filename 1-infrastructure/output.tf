output "vpc_id" {
  value = aws_vpc.production-vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.production-vpc.cidr_block
}

output "public-subnet-cidr-az1-id" {
  value = aws_subnet.public-subnet-az-1.id
}

output "public-subnet-cidr-az2-id" {
  value = "aws_subnet.public-subnet-az-2.id"
}

output "private-app-subnet-az-1-id" {
  value = aws_subnet.private-app-subnet-az-1.id
}

output "private-app-subnet-az-2-id" {
  value = aws_subnet.private-app-subnet-az-2.id
}

output "private-data-subnet-az-1-id" {
  value = aws_subnet.private-data-subnet-az-1.id
}

output "private-data-subnet-az-2-id" {
  value = aws_subnet.private-data-subnet-az-2.id
}


