variable "region" {
    description = "The aws region"
    type = string
    default = "us-west-1"
}
variable "cidr_block" {
  description = "Value of cidr_block"  
  type = string
  default = "10.0.0.0/24"

}

variable "private_subnet" {
  description = "value"
  type = string
  default = "10.0.1.0/24" 
}

variable "public_subnet" {
  description = "value"
  type = string
  default = "10.0.2.0/24" 
}

variable "aws_instance" {
  description = "value"
  type = string
  default = "t2.micro"
}