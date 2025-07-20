# VPC
#ami-0d1b5a8c13042c939
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-server-VPC2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-IGW2"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-server-Public-Subnet2"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "my-server-Private-Subnet2"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-Public-RT2"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-Private-RT2"
  }
}

# (NAT Gateway and Elastic IP resources here...)

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


# IAM Role
# (IAM Role and Policy Attachment resources here...)

# EC2 Instance in the Public Subnet
resource "aws_instance" "web_public" {
  ami                         = "ami-0d1b5a8c13042c939"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "kayla"
  tags = {
    Name = "my-server-Public-Instance2"
  }
}

# EC2 Instance in the Private Subnet
resource "aws_instance" "web_private" {
  ami                    = "ami-0d1b5a8c13042c939"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  key_name               = "kayla"
  tags = {
    Name = "my-server-Private-Instance2"
  }
}

# EBS Volume for Private EC2 Instance
resource "aws_ebs_volume" "private_instance_volume" {
  availability_zone = aws_instance.web_private.availability_zone
  size              = 8
  tags = {
    Name = "my-server-Private-Instance-Volume2"
  }
}

# Attach EBS Volume to Private EC2 Instance
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.private_instance_volume.id
  instance_id = aws_instance.web_private.id
}

