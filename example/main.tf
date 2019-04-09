terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region     = "ap-south-1"        ## because, no one ever uses this guy...
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "gateway_mesh" {
  source     = "../"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC36F95e+57q87Nu6kOwbK... ehime@grr.la"
  scenario   = "tgw-mesh-scenario"
}
