variable "access_key" {
  description = "AWS access key"
  default     = ""
}

variable "secret_key" {
  description = "AWS secret key"
  default     = ""
}

variable "region" {
  description = "AWS region which going to launch the resources"
  default     = "us-east-1"
}

variable "CidrBlock" {
  description = "CidrBlock range"
  default     = "192.168.10.0/24"
}

variable "Subnet_CidrBlock" {
  description = "Subnet_CidrBlock"
  default     = "192.168.10.0/24"
}
variable "route_cidrblock" {
  description = "route_cidrblock"
  default     = "0.0.0.0/0"
}

