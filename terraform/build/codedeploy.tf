resource "aws_codedeploy_app" "demo_app" {
  name = "${var.repository}-${var.branch}"
}

resource "aws_codedeploy_deployment_group" "demo_group" {
  app_name              = "${aws_codedeploy_app.demo_app.name}"
  deployment_group_name = "${var.repository}-${var.branch}-group"
  service_role_arn      = "${aws_iam_role.codedeploy_role.arn}"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "deployment_group"
      type  = "KEY_AND_VALUE"
      value = "${var.repository}-${var.branch}-group"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}

resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-${var.repository}-${var.branch}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codedeploy_rules_policy" {
  role = "${aws_iam_role.codedeploy_role.name}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codedeploy:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "iam:AddRoleToInstanceProfile",
                "iam:CreateInstanceProfile",
                "iam:CreateRole",
                "iam:DeleteInstanceProfile",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "iam:GetInstanceProfile",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListInstanceProfilesForRole",
                "iam:ListRolePolicies",
                "iam:ListRoles",
                "iam:PassRole",
                "iam:PutRolePolicy",
                "iam:RemoveRoleFromInstanceProfile",
                "s3:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
POLICY
}
