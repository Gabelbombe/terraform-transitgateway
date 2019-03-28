## Main Route Tables Associations
## Forcing our Route Tables to be the main ones for our VPCs,
## otherwise AWS automatically will create a main Route Table
## for each VPC, leaving our own Route Tables as secondary

resource "aws_main_route_table_association" "main-rt-vpc-1" {
  vpc_id         = "${aws_vpc.vpc-1.id}"
  route_table_id = "${aws_route_table.vpc-1-rtb.id}"
}

resource "aws_main_route_table_association" "main-rt-vpc-2" {
  vpc_id         = "${aws_vpc.vpc-2.id}"
  route_table_id = "${aws_route_table.vpc-2-rtb.id}"
}

resource "aws_main_route_table_association" "main-rt-vpc-3" {
  vpc_id         = "${aws_vpc.vpc-3.id}"
  route_table_id = "${aws_route_table.vpc-3-rtb.id}"
}

resource "aws_main_route_table_association" "main-rt-vpc-4" {
  vpc_id         = "${aws_vpc.vpc-4.id}"
  route_table_id = "${aws_route_table.vpc-4-rtb.id}"
}

## Route Tables
## Usually unecessary to explicitly create a Route Table in Terraform
## since AWS automatically creates and assigns a 'Main Route Table'
## whenever a VPC is created. However, in a Transit Gateway scenario,
## Route Tables are explicitly created so an extra route to the
## Transit Gateway could be defined
resource "aws_route_table" "vpc-1-rtb" {
  vpc_id = "${aws_vpc.vpc-1.id}"

  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"
  }

  tags = {
    Name     = "vpc-1-rtb"
    env      = "dev"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_route_table" "vpc-2-rtb" {
  vpc_id = "${aws_vpc.vpc-2.id}"

  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"
  }

  tags = {
    Name     = "vpc-2-rtb"
    env      = "dev"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_route_table" "vpc-3-rtb" {
  vpc_id = "${aws_vpc.vpc-3.id}"

  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-3-igw.id}"
  }

  tags = {
    Name     = "vpc-3-rtb"
    env      = "shared"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_route_table" "vpc-4-rtb" {
  vpc_id = "${aws_vpc.vpc-4.id}"

  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"
  }

  tags = {
    Name     = "vpc-4-rtb"
    env      = "prod"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}
