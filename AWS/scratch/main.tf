terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Cluster VPC (arockal)"
  }
}

resource "aws_subnet" "cluster_public_subnet" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "Cluster subnet (arockal)"
  }

}

resource "aws_internet_gateway" "cluster_internet_gateway" {
  vpc_id = aws_vpc.cluster_vpc.id


  tags = {
    Name = "Cluster internet GW (arockal)"
  }
}

resource "aws_route_table" "cluster_public_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id

  tags = {
    Name = "Cluster public RT (arockal)"
  }
}

resource "aws_route" "cluster_route" {
  route_table_id         = aws_route_table.cluster_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cluster_internet_gateway.id
}

resource "aws_route_table_association" "cluster_rt_association" {
  subnet_id      = aws_subnet.cluster_public_subnet.id
  route_table_id = aws_route_table.cluster_public_route_table.id
}

resource "aws_security_group" "instance" {
  name        = "terraform-example-instance"
  description = "Server+SSH+WG+Internet (Managed by Terraform)"
  vpc_id      = aws_vpc.cluster_vpc.id
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.wg_port
    to_port     = var.wg_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
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

# resource "aws_network_interface" "master_network_interface" {
#   subnet_id       = aws_subnet.cluster_public_subnet.id
#   private_ips     = ["10.0.10.101"]
#   security_groups = ["${aws_security_group.instance.id}"]
#   tags = {
#     Name = "terraform_primary_network_interface"
#   }
# }

resource "aws_instance" "app_server" {
  ami                    = "ami-09e03e6bd1ff7ec01"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = aws_subnet.cluster_public_subnet.id
  key_name               = aws_key_pair.ssh_key.key_name
  # private_ip                  = "172.31.10.101"
  user_data                   = <<-EOF
#!/bin/bash
  curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/test.html > index.html
  nohup busybox httpd -f -p ${var.server_port} &
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_instance_name
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key_value"
  public_key = var.ssh_key
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

