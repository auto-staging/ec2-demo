resource "aws_lb_target_group_attachment" "attach" {
  count            = "${var.instance_count}"
  target_group_arn = "${data.terraform_remote_state.alb.lb_target_group_arn}"
  target_id        = "${element(aws_instance.demo_app.*.id, count.index)}"
  port             = 8080
}
