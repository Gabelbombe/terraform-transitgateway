terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region = "ap-south-1" ## because, no one ever uses this guy...
}

module "gateway_mesh" {
  source     = "../"
  public_key = "ssh-rsa AAAAB3NzaC1y...qd4hssndQ== rsa-key-20180518"
  scenario   = "tgw-mesh-scenario"
}
