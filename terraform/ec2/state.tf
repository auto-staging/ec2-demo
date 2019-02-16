terraform {
  backend "s3" {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "ec2-demo/ec2/terraform.tfstate"
    region = "eu-central-1"
  }
}
