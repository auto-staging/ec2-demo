module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.repository}-${var.branch}-vpc"
  cidr = "10.1.0.0/16"

  azs            = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform  = "true"
    Repository = "${var.repository}"
    Branch     = "${var.branch}"
  }
}
