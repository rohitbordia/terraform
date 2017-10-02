#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-d651b8ac
#
# Your subnet ID is:
#
#     subnet-a2a469e9
#
# Your security group ID is:
#
#     sg-2788a154
#
# Your Identity is:
#
#     NWI-vault-salamander

terraform {
  backend "atlas" {
    name    = "rohitbordia/example"
   }
}
#

module "example"{
	source = "./example-module"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "aws_access_key" {
 type = "string"
}

variable "aws_secret_key" {
 type = "string"
}

variable "aws_region" {
  type= "string" 
  default = "us-east-1" 
}

resource "aws_instance" "web" {
  # ...
  instance_type          = "t2.micro"
  ami                    = "ami-d651b8ac"
  subnet_id              = "subnet-a2a469e9"
  vpc_security_group_ids = ["sg-2788a154"]

  tags {
    Identity = "NWI-vault-salamander", 
    name = "web  ${count.index} + 1 ",
    title = "Engineer"
  }
}
