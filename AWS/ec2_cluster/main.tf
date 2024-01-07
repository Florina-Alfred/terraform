resource "aws_instance" "master_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.101"
  user_data                   = <<-EOF
#!/bin/bash
sudo hostnamectl set-hostname ${var.master_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
# echo "Hello, Master" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
                                EOF
  user_data_replace_on_change = true
  tags = {
    Name = var.master_instance_name
  }
}

resource "aws_instance" "worker_1_server" {
  ami                         = "ami-09e03e6bd1ff7ec01"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.cluster_security_group.id]
  subnet_id                   = aws_subnet.cluster_public_subnet.id
  key_name                    = aws_key_pair.ssh_key.key_name
  private_ip                  = "10.0.10.102"
  user_data                   = <<-EOF
#!/bin/bash
sudo hostnamectl set-hostname ${var.worker_1_instance_name}
curl https://raw.githubusercontent.com/Florina-Alfred/terraform/main/unix/setup.sh > setup.sh
sudo bash setup.sh
sudo reboot
# echo "Hello, Master" > index.html
# nohup busybox httpd -f -p ${var.server_port} &
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
  private_ip                  = "10.0.10.103"
  user_data                   = <<-EOF
                                #!/bin/bash

                                # echo "Hello, Master" > index.html
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

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key_value"
  public_key = var.ssh_key
}

