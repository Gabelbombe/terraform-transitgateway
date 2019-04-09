## Transit Gateway
## Default association and propagation are disabled since our scenario involves a more elaborated setup where
## - Dev VPCs can reach themselves and the Shared VPC
## - the Shared VPC can reach all VPCs
## - the Prod VPC can only reach the Shared VPC
## The default setup being a full mesh scenario where all VPCs can see every other
resource "aws_ec2_transit_gateway" "test-tgw" {
  description = "Transit Gateway testing scenario with 4 VPCs, 2 subnets each"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name     = "${var.scenario}"
    scenario = "${var.scenario}"
  }
}

## VPC attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-1" {
  vpc_id             = "${aws_vpc.vpc-1.id}"
  subnet_ids         = ["${aws_subnet.vpc-1-sub-a.id}", "${aws_subnet.vpc-1-sub-b.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name     = "tgw-att-vpc1"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-2" {
  vpc_id             = "${aws_vpc.vpc-2.id}"
  subnet_ids         = ["${aws_subnet.vpc-2-sub-a.id}", "${aws_subnet.vpc-2-sub-b.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name     = "tgw-att-vpc2"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-3" {
  vpc_id             = "${aws_vpc.vpc-3.id}"
  subnet_ids         = ["${aws_subnet.vpc-3-sub-a.id}", "${aws_subnet.vpc-3-sub-b.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name     = "tgw-att-vpc3"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-4" {
  vpc_id             = "${aws_vpc.vpc-4.id}"
  subnet_ids         = ["${aws_subnet.vpc-4-sub-a.id}", "${aws_subnet.vpc-4-sub-b.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name     = "tgw-att-vpc4"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

## Route Tables
resource "aws_ec2_transit_gateway_route_table" "tgw-dev-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  tags = {
    Name     = "tgw-dev-rt"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_ec2_transit_gateway_route_table" "tgw-shared-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  tags = {
    Name     = "tgw-shared-rt"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

resource "aws_ec2_transit_gateway_route_table" "tgw-prod-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.test-tgw.id}"

  tags = {
    Name     = "tgw-prod-rt"
    scenario = "${var.scenario}"
  }

  depends_on = ["aws_ec2_transit_gateway.test-tgw"]
}

## Route Tables Associations
## This is the link between a VPC (already symbolized with its attachment to the Transit Gateway)
##  and the Route Table the VPC's packet will hit when they arrive into the Transit Gateway.
## The Route Tables Associations do not represent the actual routes the packets are routed to.
## These are defined in the Route Tables Propagations section below.
resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-1-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dev-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-2-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-2.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dev-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-3-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-3.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-4-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-4.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}

## Route Tables Propagations
## This section defines which VPCs will be routed from each Route Table created in the Transit Gateway
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dev-to-vpc-1" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dev-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dev-to-vpc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-2.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dev-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dev-to-vpc-3" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-3.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dev-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-1" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-2.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-4" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-4.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-prod-to-vpc-3" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-3.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}
