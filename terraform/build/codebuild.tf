resource "aws_iam_role" "build_demo_app_role" {
  name = "codebuild-${var.repository}-${var.branch}-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "build_demo_app_policy" {
  role = "${aws_iam_role.build_demo_app_role.name}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "s3:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
POLICY
}

resource "aws_codebuild_project" "build_demo_app" {
  build_timeout = "60"
  name          = "build-${var.repository}-${var.branch}"
  service_role  = "${aws_iam_role.build_demo_app_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/golang:1.10"
    privileged_mode = true
    type            = "LINUX_CONTAINER"
  }

  source {
    buildspec = "buildspec.yml"
    type      = "CODEPIPELINE"
  }
}
