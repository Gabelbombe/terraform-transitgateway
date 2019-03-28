terraform {
  required_version = ">= 0.11.7"
}

data "aws_availability_zones" "available" {}

provider "aws" {
  region = "ap-south-1" ## no one ever uses this guy...
}
