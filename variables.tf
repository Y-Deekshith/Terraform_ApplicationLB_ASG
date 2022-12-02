variable "region" {
    default = "us-east-1"
}
variable "vpc_cidr" {
    default = "10.10.0.0/16"
}
variable "subnet_cidr1" {
    default = "10.10.1.0/24"
}
variable "subnet_cidr2" {
    default = "10.10.2.0/24"
}
variable "ami_id" {
    default = "ami-0b0dcb5067f052a63"
}
variable "instance_tenancy" {
    default = "default"
}
variable "cidr_blocks" {
    default = ["0.0.0.0/0"]
}
variable "instancetype" {
    default = "t2.micro"
}