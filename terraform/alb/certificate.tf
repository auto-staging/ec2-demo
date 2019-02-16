resource "aws_lb_listener_certificate" "alb_certificate" {
  listener_arn    = "${aws_lb_listener.https_listener.arn}"
  certificate_arn = "${data.aws_acm_certificate.cert.arn}"
}

data "aws_acm_certificate" "cert" {
  domain   = "*.janrtr.space"
  statuses = ["ISSUED"]
}
