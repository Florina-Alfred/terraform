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

resource "aws_instance" "app_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.instance.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "172.31.24.101"
  user_data                   = <<-EOF
#!/bin/bash
sudo hostnamectl set-hostname ${var.instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/test.html > index.html
nohup busybox httpd -f -p 8080 &
# curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
#     sudo bash setup.sh
#     sudo reboot
EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.instance_name
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
    from_port   = var.kubectl_port
    to_port     = var.kubectl_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.lb_http_port
    to_port     = var.lb_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.lb_https_port
    to_port     = var.lb_https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.lb_metrics_port
    to_port     = var.lb_metrics_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.lb_traefik_port
    to_port     = var.lb_traefik_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.tester
    to_port     = var.tester
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
  key_name = "ssh_key_value"
  public_key = file("/home/user/.ssh/id_ed25519.pub")
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
