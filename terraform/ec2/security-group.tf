resource "aws_security_group" "allow_all" {
  name        = "allow_all_${var.repository}_${var.branch}"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_from_lb" {
  name        = "allow_from_lb_${var.repository}_${var.branch}"
  description = "Allow HTTP 8080 from lb"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.alb.lb_security_group_id}"]
  }
}
