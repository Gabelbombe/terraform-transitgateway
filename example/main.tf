terraform {
  required_version = ">= 0.11.7"
}

data "aws_availability_zones" "available" {}

provider "aws" {
  ## Unused, because I use aws-vault
  ## Uncomment here and in variables.tf to access
  # access_key = "${var.access_key}"
  # secret_key = "${var.secret_key}"
  region = "${var.region}" ## defaults: ap-south-1 :: no one ever uses this guy...
}
