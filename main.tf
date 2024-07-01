resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyTerraformVpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet
  map_public_ip_on_launch = true 
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_subnet
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_security_group" "nginx_sg" {
  
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx_sg"
  }
}

resource "aws_instance" "nginx_instance" {
  ami                    = "ami-08012c0a9ee8e21c4"
  instance_type          = var.aws_instance
  subnet_id              = aws_subnet.public_subnet.id
 
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1.12 -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "nginx_instance"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-statefile"
    key    = "path/to/terraform.tfstate"
    region = var.region
  }
}
