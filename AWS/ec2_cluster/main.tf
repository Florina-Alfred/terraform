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

resource "aws_instance" "master_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  #vpc_security_group_ids      = [aws_security_group.instance.id]
  private_ip                  = "172.31.10.101"
  # network_interface {
  #   network_interface_id = aws_network_interface.master_network_interface.id
  #   device_index         = 0
  # }

  key_name                    = aws_key_pair.ssh_key.key_name
  user_data                   = <<-EOF
                                #!/bin/bash
                                echo "Hello, Master" > index.html
                                nohup busybox httpd -f -p ${var.server_port} &
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_instance_name
  }
}

resource "aws_instance" "worker_1_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  #vpc_security_group_ids      = [aws_security_group.instance.id]
  private_ip                  = "172.31.10.102"
  # network_interface {
  #   network_interface_id = aws_network_interface.worker_1_network_interface.id
  #   device_index         = 0
  # }
  key_name                    = aws_key_pair.ssh_key.key_name
  user_data                   = <<-EOF
                                #!/bin/bash
                                echo "Hello, Worker 1" > index.html
                                nohup busybox httpd -f -p ${var.server_port} &
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_1_instance_name
  }
}

resource "aws_instance" "worker_2_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  #vpc_security_group_ids      = [aws_security_group.instance.id]
  private_ip                  = "172.31.10.103"
  # network_interface {
  #   network_interface_id = aws_network_interface.worker_2_network_interface.id
  #   device_index         = 0
  # }
  key_name                    = aws_key_pair.ssh_key.key_name
  user_data                   = <<-EOF
                                #!/bin/bash
                                echo "Hello, Worker 2" > index.html
                                nohup busybox httpd -f -p ${var.server_port} &
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_2_instance_name
  }
}

# resource "aws_vpc" "cluster_vpc" {
#   cidr_block = "172.16.0.0/16"
#
#   tags = {
#     Name = "tf-cluster-vpc"
#   }
# }
#
# resource "aws_subnet" "cluster_subnet" {
#   vpc_id            = aws_vpc.cluster_vpc.id
#   cidr_block        = "172.16.10.0/24"
#   availability_zone = "us-east-2a"
#
#   map_public_ip_on_launch = true
#
#   tags = {
#     Name = "tf-cluster-vpc"
#   }
# }
#
# resource "aws_network_interface" "master_network_interface" {
#   subnet_id   = aws_subnet.cluster_subnet.id
#   private_ips = ["172.16.10.101"]
#   security_groups = ["${aws_security_group.instance.id}"]
#   tags = {
#     Name = "terraform_primary_network_interface"
#   }
# }
#
# resource "aws_network_interface" "worker_1_network_interface" {
#   subnet_id   = aws_subnet.cluster_subnet.id
#   private_ips = ["172.16.10.102"]
#   security_groups = ["${aws_security_group.instance.id}"]
#   tags = {
#     Name = "terraform_primary_network_interface"
#   }
# }
#
# resource "aws_network_interface" "worker_2_network_interface" {
#   subnet_id   = aws_subnet.cluster_subnet.id
#   private_ips = ["172.16.10.103"]
#   security_groups = ["${aws_security_group.instance.id}"]
#   tags = {
#     Name = "terraform_primary_network_interface"
#   }
# }
#
# resource "aws_security_group" "instance" {
#   name = "terraform-example-instance"
#   vpc_id = aws_vpc.cluster_vpc.id
#   ingress {
#     from_port   = var.ssh_port
#     to_port     = var.ssh_port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = var.wg_port
#     to_port     = var.wg_port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = var.server_port
#     to_port     = var.server_port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
###################################

###################################
#
#resource "aws_internet_gateway" "example" {
#  vpc_id = aws_vpc.cluster_vpc.id
#}
#
#resource "aws_route_table" "public" {
#  vpc_id = aws_vpc.cluster_vpc.id
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id  = aws_internet_gateway.example.id
#  }
#
#  tags = {
#    Name = "public"
#  }
#}
#
#resource "aws_subnet" "public_subnet" {
#  vpc_id            = aws_vpc.cluster_vpc.id
#  cidr_block        = "172.16.20.0/24"  # Adjust the CIDR block as needed
#  availability_zone = "us-east-2a"
#  
#  map_public_ip_on_launch = true  # This enables automatic public IP assignment
#
#route_table_association {
#    subnet_id      = aws_subnet.public_subnet.id
#    route_table_id = aws_route_table.public.id
#  }
#
#  tags = {
#    Name = "public_subnet"
#  }
#}

#########################

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key_value"
  public_key = var.ssh_key
}

output "master_instance_id" {
  description = "ID of the EC2 Master instance"
  value       = aws_instance.master_server.id
}

output "master_public_ip" {
  description = "Public IP address of the EC2 Master instance"
  value       = aws_instance.master_server.public_ip
}

output "worker_1_instance_id" {
  description = "ID of the EC2 Master instance"
  value       = aws_instance.worker_1_server.id
}

output "worker_1_public_ip" {
  description = "Public IP address of the EC2 Master instance"
  value       = aws_instance.worker_1_server.public_ip
}

output "worker_2_instance_id" {
  description = "ID of the EC2 Master instance"
  value       = aws_instance.worker_2_server.id
}

output "worker_2_public_ip" {
  description = "Public IP address of the EC2 Master instance"
  value       = aws_instance.worker_2_server.public_ip
}
