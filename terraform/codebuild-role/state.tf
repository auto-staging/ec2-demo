terraform {
  backend "s3" {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "ec2-demo/codebuild-role/terraform.tfstate"
    region = "eu-central-1"
  }
}
