terraform {
  backend "s3" {
    bucket = "janrtr-infrastructure-terraform-state"
    key    = "demo-app/build/terraform.tfstate"
    region = "eu-central-1"
  }
}
