resource "aws_lb" "myalb" {
    name               = "applb"
    internal           = false
    load_balancer_type = "application"
    security_groups = ["${aws_security_group.terraform_sg.id}"]
    subnets = [ "${aws_subnet.publicsubnet1.id}","${aws_subnet.publicsubnet2.id}" ]

  enable_deletion_protection = true      //check and confirm

  tags = {
    Environment = "production"
  }
}
output "albarn_output" {
    value = "${aws_lb.myalb.arn}"
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "albtargetgp"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.main.id}"
}
output "tgarn_output" {
    value = "${aws_lb_target_group.alb_tg.arn}"
}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = "${aws_lb.myalb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
  }
}

//need to associate instance targets in target groups check once