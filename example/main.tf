terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region = "ap-south-1" ## because, no one ever uses this guy...
}
