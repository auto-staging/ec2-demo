data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "terraform_remote_state" "alb" {
  backend = "s3"

  config {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "env:/${var.branch}/ec2-demo/alb/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "env:/${var.branch}/ec2-demo/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
