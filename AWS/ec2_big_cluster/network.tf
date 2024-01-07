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

# resource "aws_network_interface" "master_network_interface" {
#   subnet_id       = aws_subnet.cluster_public_subnet.id
#   private_ips     = ["10.0.10.101"]
#   security_groups = ["${aws_security_group.instance.id}"]
#   tags = {
#     Name = "terraform_primary_network_interface"
#   }
# }
