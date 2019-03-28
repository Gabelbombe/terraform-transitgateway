## VPCs
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name     = "${var.scenario}-vpc1-dev"
    scenario = "${var.scenario}"
    env      = "dev"
  }
}

resource "aws_vpc" "vpc-2" {
  cidr_block = "10.11.0.0/16"

  tags = {
    Name     = "${var.scenario}-vpc2-dev"
    scenario = "${var.scenario}"
    env      = "dev"
  }
}

resource "aws_vpc" "vpc-3" {
  cidr_block = "10.12.0.0/16"

  tags = {
    Name     = "${var.scenario}-vpc3-shared"
    scenario = "${var.scenario}"
    env      = "shared"
  }
}

resource "aws_vpc" "vpc-4" {
  cidr_block = "10.13.0.0/16"

  tags = {
    Name     = "${var.scenario}-vpc4-prod"
    scenario = "${var.scenario}"
    env      = "prod"
  }
}

## Subnets
resource "aws_subnet" "vpc-1-sub-a" {
  vpc_id            = "${aws_vpc.vpc-1.id}"
  cidr_block        = "10.10.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${aws_vpc.vpc-1.tags.Name}-sub-a"
  }
}

resource "aws_subnet" "vpc-1-sub-b" {
  vpc_id            = "${aws_vpc.vpc-1.id}"
  cidr_block        = "10.10.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${aws_vpc.vpc-1.tags.Name}-sub-b"
  }
}

resource "aws_subnet" "vpc-2-sub-a" {
  vpc_id            = "${aws_vpc.vpc-2.id}"
  cidr_block        = "10.11.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${aws_vpc.vpc-2.tags.Name}-sub-a"
  }
}

resource "aws_subnet" "vpc-2-sub-b" {
  vpc_id            = "${aws_vpc.vpc-2.id}"
  cidr_block        = "10.11.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${aws_vpc.vpc-2.tags.Name}-sub-b"
  }
}

resource "aws_subnet" "vpc-3-sub-a" {
  vpc_id            = "${aws_vpc.vpc-3.id}"
  cidr_block        = "10.12.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${aws_vpc.vpc-3.tags.Name}-sub-a"
  }
}

resource "aws_subnet" "vpc-3-sub-b" {
  vpc_id            = "${aws_vpc.vpc-3.id}"
  cidr_block        = "10.12.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${aws_vpc.vpc-3.tags.Name}-sub-b"
  }
}

resource "aws_subnet" "vpc-4-sub-a" {
  vpc_id            = "${aws_vpc.vpc-4.id}"
  cidr_block        = "10.13.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${aws_vpc.vpc-4.tags.Name}-sub-a"
  }
}

resource "aws_subnet" "vpc-4-sub-b" {
  vpc_id            = "${aws_vpc.vpc-4.id}"
  cidr_block        = "10.13.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${aws_vpc.vpc-4.tags.Name}-sub-b"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "vpc-3-igw" {
  vpc_id = "${aws_vpc.vpc-3.id}"

  tags = {
    Name     = "vpc-3-igw"
    scenario = "${var.scenario}"
  }
}
