variable "region" {
    description = "The aws region"
    type = string
    
}
variable "cidr_block" {
  description = "Value of cidr_block"  
  type = string
  

}

variable "private_subnet_cidr_val" {
  description = "value"
  type = string
  
}

variable "public_subnet_cidr_val" {
  description = "value"
  type = string
 
}

variable "aws_instance_ty" {
  description = "value"
  type = string
  
}

variable "environment" {
  description = "defines working env"
  type = string
}