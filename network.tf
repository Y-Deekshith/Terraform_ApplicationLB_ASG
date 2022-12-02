resource "aws_vpc" "main" {
        cidr_block = var.vpc_cidr
        instance_tenancy = var.instance_tenancy

        tags = {
        Name = "Deevpc"
}
}
output "vpc_id" {
    value = aws_vpc.main.id
}
resource "aws_subnet" "publicsubnet1" {
        vpc_id = aws_vpc.main.id
        cidr_block = var.subnet_cidr1
        map_public_ip_on_launch = true
        availability_zone = "us-east-1a"

        tags = {
        Name = "deesubnet1"
}
}
resource "aws_subnet" "publicsubnet2" {
        vpc_id = aws_vpc.main.id
        cidr_block = var.subnet_cidr2
        map_public_ip_on_launch = true
        availability_zone = "us-east-1b"

        tags = {
        Name = "deesubnet2"
}
}
resource "aws_internet_gateway" "ig" {
        vpc_id = aws_vpc.main.id

       tags = {
       Name = "Internetgatway"
}
}

resource "aws_route_table" "mrtb"{
        vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
        tags = {
        Name = "MainRT"
  }
}

resource "aws_route_table_association" "pub_rt_asso1" {
        subnet_id      = aws_subnet.publicsubnet1.id
        route_table_id = aws_route_table.mrtb.id
}
resource "aws_route_table_association" "pub_rt_asso2" {
        subnet_id      = aws_subnet.publicsubnet2.id
        route_table_id = aws_route_table.mrtb.id
}