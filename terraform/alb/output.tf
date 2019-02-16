output "lb_security_group_id" {
  value = "${aws_security_group.load_balancer_security_group.id}"
}

output "lb_target_group_arn" {
  value = "${aws_lb_target_group.http_tg.arn}"
}

output "lb_arn" {
  value = "${aws_lb.demo_app.arn}"
}

output "dns_entry" {
  value = "${aws_route53_record.record.name}"
}
