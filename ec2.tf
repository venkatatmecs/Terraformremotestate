provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

data "terraform_remote_state" "CustomVPC" {
  backend = "s3"
  config {
    bucket = "terraformstatefile12345"
    key = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
 backend "s3" {
    bucket = "terraformstatefile12345"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformstatefile"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  subnet_id = "${data.terraform_remote_state.CustomVPC.publicsubnet}"
 
tags = {
    Name = "HelloWorld"
  }
}
