provider "aws" {
	shared_credentials_file = var.shared_cred_file
	region = var.region
}

module "networkModule" {
  source = "./module/network"
}

resource "aws_instance" "bastionInstance" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id = module.networkModule.public_subnet_id
  vpc_security_group_ids = [module.networkModule.bastion_security_id]
  key_name = "terraform"
}

resource "aws_security_group" "allow_bastion" {
  name        = "allow_bastion"
  description = "Allow connection to Bastion Instance"
  vpc_id      = module.networkModule.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [module.networkModule.bastion_security_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_bastion"
  }
}

resource "aws_instance" "privateInstance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = module.networkModule.private_subnet_id
  vpc_security_group_ids = [aws_security_group.allow_bastion.id]
	depends_on = [
    aws_security_group.allow_bastion,
  ]
  key_name = "terraform"


}
