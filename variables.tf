variable "region" {
  default = "ap-south-1"
}

variable "shared_cred_file" {
  default = "/Documents/terraform-workspace/.aws/credentials"
}

variable "bastion_ami" {
  default = "ami-0e8710d48cc4ea8dd"
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0db0b3ab7df22e366"
}
variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}
