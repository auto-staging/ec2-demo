resource "aws_iam_role" "infrastructure_codebuild_exec_role" {
  name = "ec2-demo-infrastructure-codebuild-exec-role"

  assume_role_policy = "${data.aws_iam_policy_document.infrastructure-codebuild-assume-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "infrastructure_codebuild_policy_attachment" {
  role       = "${aws_iam_role.infrastructure_codebuild_exec_role.name}"
  policy_arn = "${aws_iam_policy.infrastructure_codebuild_execution.arn}"
}

data "aws_iam_policy_document" "infrastructure-codebuild-assume-role-policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "infrastructure_codebuild_execution" {
  policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
            "acm:DescribeCertificate",
            "acm:ListCertificates",
            "codebuild:*",
            "codedeploy:*",
            "codepipeline:*",
            "ec2:*",
            "elasticloadbalancing:*",
            "iam:*",
            "lambda:InvokeFunction",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "route53:ChangeResourceRecordSets",
            "route53:GetChange",
            "route53:GetHostedZone",
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets",
            "s3:*",
            "ssm:GetParameters",
            "vpc:*"
           ],
           "Resource": "*"
       }
   ]
}
POLICY
}
