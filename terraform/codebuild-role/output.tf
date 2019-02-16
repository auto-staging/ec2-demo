output "codebuild_role_arn" {
  value = "${aws_iam_role.infrastructure_codebuild_exec_role.arn}"
}
