resource "aws_instance" "demo_app" {
  ami           = "${data.aws_ami.ubuntu.id}"
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  key_name      = "jan"

  iam_instance_profile = "${aws_iam_instance_profile.deployment_profile.name}"

  security_groups = ["${aws_security_group.allow_all.id}",
    "${aws_security_group.allow_from_lb.id}",
  ]

  subnet_id = "${element(data.terraform_remote_state.vpc.public_subnet_ids, count.index)}"
  user_data = "${file("user_data.sh")}"

  tags {
    Name             = "${var.repository}-${var.branch}-${count.index}"
    deployment_group = "${var.repository}-${var.branch}-group"
    branch_raw       = "${var.branch_raw}"
    repository       = "${var.repository}"
  }
}

resource "aws_iam_instance_profile" "deployment_profile" {
  name = "deployment-${var.repository}-${var.branch}-profile"
  role = "${aws_iam_role.deployment_role.name}"
}

resource "aws_iam_role" "deployment_role" {
  name = "deployments-${var.repository}-${var.branch}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "deplyoment_role_policy" {
  role = "${aws_iam_role.deployment_role.name}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
POLICY
}
