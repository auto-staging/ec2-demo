resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.repository}-${var.branch}.janrtr.space"
  type    = "A"

  alias {
    name                   = "${aws_lb.demo_app.dns_name}"
    zone_id                = "${aws_lb.demo_app.zone_id}"
    evaluate_target_health = true
  }
}
