data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "env:/${var.branch}/ec2-demo/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "aws_route53_zone" "primary" {
  name = "janrtr.space"
}
