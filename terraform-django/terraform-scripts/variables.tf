variable "aws_region" {
type = string
description = "The AWS region."
}

variable "ami" {
type = map(string)
description = "A map of AMIs."
default = {}
}
variable "instance_type" {
type = string
description = "The instance type."
default = "t2.micro"
}
variable "vpc_cidr" {
	default = "10.20.0.0/16"
}
variable "subnets_cidr" {
	type = list(string)
	default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnets_cidr" {
        type = list(string)
        default = ["10.20.3.0/24", "10.20.4.0/24"]
}


variable "azs" {
	type = list(string)
	default = ["eu-west-1a", "eu-west-1b"]
}

variable "my_inbound" {
    type=map(list(string))
    default={
     "22" = ["103.226.146.202/32","45.127.44.46/32"]
     "8080" = ["103.226.146.202/32","45.127.44.46/32"]
}
}
variable "my_outbound" {
    type=map(list(string))
    default={
     "0" = ["0.0.0.0/0"]
}

}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8000
}

variable "elb_port" {
  description = "The port the ELB will use for HTTP requests"
  type        = number
  default     = 8080
}
