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
  vpc_security_group_ids      = [aws_security_group.instance.id]
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
  vpc_security_group_ids      = [aws_security_group.instance.id]
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
  vpc_security_group_ids      = [aws_security_group.instance.id]
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

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
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
