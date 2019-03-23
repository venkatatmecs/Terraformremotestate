provider "aws"
{
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "${var.region}"
}

terraform {
 backend "s3" {
    bucket = "terraformstatefile12345"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformstatefile"
  }
}

resource "aws_vpc" "CustomVPC" {
  cidr_block       = "${var.CidrBlock}"
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = "${aws_vpc.CustomVPC.id}"
  cidr_block = "${var.Subnet_CidrBlock}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id   = "${aws_vpc.CustomVPC.id}"
}

resource "aws_route_table" "rtb" {
  vpc_id           = "${aws_vpc.CustomVPC.id}"
    route {
    cidr_block = "${var.route_cidrblock}"
    gateway_id = "${aws_internet_gateway.igw.id}"
    }
}
resource "aws_route_table_association" "pubsubnet" {
   subnet_id = "${aws_subnet.publicsubnet.id}"
   route_table_id = "${aws_route_table.rtb.id}"
}



output "CustomVPC" {
  description = "vpc id"
  value       = "${aws_vpc.CustomVPC.id}"
}
output "publicsubnet" {
  description = "subnet id"
  value       = "${aws_subnet.publicsubnet.id}"
}


