resource "aws_security_group" "terraform_sg" {
        name    =       "terraform_sg"
        description = "terraform sg for ec2 instance"
        vpc_id  = "${aws_vpc.main.id}"

ingress{
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks = "${var.cidr_blocks}"
        }
ingress{
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks = "${var.cidr_blocks}"
        }
ingress{
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks = "${var.cidr_blocks}"
        }

egress{
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks = "${var.cidr_blocks}"
        }
}
output "sgoutput" {
    value = "${aws_security_group.terraform_sg.id}"
}