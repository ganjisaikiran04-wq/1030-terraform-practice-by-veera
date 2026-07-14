#creation of VPC with custom network configuration
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}
#creation of subnet with custom network configuration
resource "aws_subnet" "dev_subnet" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "dev-subnet"
  }
}
#creation of internet gateway with custom network configuration
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-igw"
  }
}

#Creation of route table with custom network configuration
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-route-table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
}
#Creation of route table association with custom network configuration
resource "aws_route_table_association" "dev_route_table_association" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
}
#Creation of security group with custom network configuration
resource "aws_security_group" "dev_sg" {
    name        = "dev-security-group"
    description = "Allow SSH and HTTP traffic"
    vpc_id      = aws_vpc.dev_vpc.id
    
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
}
#Creation of EC2 instance with custom network configuration
resource "aws_instance" "dev_instance" {
    ami = "ami-002192a70217ac181"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.dev_subnet.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "dev-instance"
    }
  
}

#create private server with nat gateway 