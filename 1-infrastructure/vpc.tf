# Create vpc
resource "aws_vpc" "production-vpc" {
    cidr_block       = "${var.vpc_cidr}" 
    instance_tenancy = "default"
    enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

  