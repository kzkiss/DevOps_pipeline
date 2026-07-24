#create aws vpc
resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  tags = {
    name = "lw-devops-pipeline-vpc"
  }
}

#create subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "eu-west-2a"

  map_public_ip_on_launch = true

  tags = {

    name = "lw-devops-pipeline-subnet"
  }
}

#create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "lw-devops-pipeline-internet-gateway"
  }
}

#create route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    name = "lw-devops-pipeline-route-table"
  }
}

#associate route table with subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

#create security group
resource "aws_security_group" "api" {
  name        = "lw-devops-pipeline-security"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




#create elastic IP
resource "aws_eip" "api" {
  domain = "vpc"

  tags = {
    Name = "lw-devops-pipeline-eip"
  }
}

#associate elastic IP with instance
resource "aws_eip_association" "api" {
  instance_id   = aws_instance.api.id
  allocation_id = aws_eip.api.id
}

#elastic IP output
output "api_public_ip" {
  value = aws_eip.api.public_ip
}

#create ec2 instance, initialise docker on instance
resource "aws_instance" "api" {
  ami           = "ami-0044a84051c9d8748"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [
    aws_security_group.api.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y docker.io
                systemctl start docker
                systemctl enable docker
                usermod -aG docker ubuntu

                EOF



  tags = {
    Name = "lw-devops-pipeline-api"
  }
}
