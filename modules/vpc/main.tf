resource "aws_vpc" "gitlab" {
    
    cidr_block = var.cidr_block

    tags = {
        Name = var.vpc_name
        Environment = var.env_tag
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.gitlab.id

    tags = {
        Environment = var.env_tag
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.gitlab.id
    cidr_block = var.cidr_subnet
    map_public_ip_on_launch = "true"
    availability_zone = var.availability_zone

    tags = {
        Environment = var.env_tag
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.gitlab.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Environment = var.env_tag
    }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_security_group" "jenkins_sg" {
  name = "jenkins_sg"
  vpc_id = aws_vpc.gitlab.id

  ingress {
    description = "HTTP for Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
        Environment = var.env_tag
    }
}