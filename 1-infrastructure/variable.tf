# Create variables for your network infrastructure
variable "region" {
  default = "us-east-1"
}


variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "public-subnet-az-1-cidr" {
  default     = "10.0.0.0/24"
  description = "public az 1 cidr block"

}

variable "public-subnet-az-2-cidr" {
  default     = "10.0.1.0/24"
  description = "private az 3 cidr block"
}

variable "private-app-subnet-az-1-cidr" {
  default     = "10.0.2.0/24"
  description = "private app subnet az 1 cidr block"
}

variable "private-app-subnet-az-2-cidr" {
  default     = "10.0.3.0/24"
  description = "private app subnet az 2 cidr block"
}

variable "private-data-subnet-az-1-cidr" {
  default     = "10.0.4.0/24"
  description = "private data subnet az 1 cidr block"

}

variable "private-data-subnet-az-2-cidr" {
  default     = "10.0.5.0/24"
  description = "private data subnet az 2 cidr block"
}
