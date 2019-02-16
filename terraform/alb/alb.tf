resource "aws_lb" "demo_app" {
  name               = "${var.repository}-${var.branch}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancer_security_group.id}"]
  subnets            = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = "${aws_lb.demo_app.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${data.aws_acm_certificate.cert.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.http_tg.arn}"
  }
}

resource "aws_lb_listener" "http_tg" {
  load_balancer_arn = "${aws_lb.demo_app.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "http_tg" {
  name     = "tg-demo-app-${var.branch}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"

  health_check {
    path     = "/"
    protocol = "HTTP"
    interval = 5
    timeout  = 4
  }
}
