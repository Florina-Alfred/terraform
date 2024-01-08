resource "aws_instance" "master_1_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.101"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Master 1" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.master_1_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_1_instance_name
  }
}

resource "aws_instance" "master_2_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.102"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Master 2" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.master_2_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_2_instance_name
  }
}

resource "aws_instance" "master_3_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.103"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Master 3" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.master_3_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_3_instance_name
  }
}

resource "aws_instance" "worker_1_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.201"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Worker 1" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.worker_1_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_1_instance_name
  }
}

resource "aws_instance" "worker_2_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.202"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Worker 2" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.worker_2_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_2_instance_name
  }
}

resource "aws_instance" "worker_3_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.203"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Worker 3" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.worker_3_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_3_instance_name
  }
}

resource "aws_instance" "worker_4_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.204"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Worker 4" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.worker_4_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_4_instance_name
  }
}

resource "aws_instance" "worker_5_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.205"
  user_data                   = <<-EOF
#!/bin/bash
# echo "Hello, Worker 5" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
sudo hostnamectl set-hostname ${var.worker_5_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.worker_5_instance_name
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key_value"
  public_key = file("/home/user/.ssh/id_ed25519.pub")
}

