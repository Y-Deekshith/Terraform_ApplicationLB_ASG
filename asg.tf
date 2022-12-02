resource "aws_launch_configuration" "launchconfig" {
  name_prefix   = "terraform"
  image_id      = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name = "NVirginiaPC"

    security_groups = [ "${aws_security_group.terraform_sg.id}" ]
    associate_public_ip_address = true
    user_data = "${file("data_add.sh")}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
    name = "${aws_launch_configuration.launchconfig.name}-asg"
    max_size = 4
    min_size = 2
    desired_capacity = 2
    #load_balancers = [ "${aws_lb.myalb.id}" ]

    launch_configuration = "${aws_launch_configuration.launchconfig.name}"
    
    vpc_zone_identifier  = ["${aws_subnet.publicsubnet1.id}","${aws_subnet.publicsubnet2.id}"]

    lifecycle {
    create_before_destroy = true
    }
    tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }
}