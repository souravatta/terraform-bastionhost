variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az" {
  default = "ap-south-1a"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}
