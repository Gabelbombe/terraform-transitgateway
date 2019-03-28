## Key Pair
resource "aws_key_pair" "test-tgw-keypair" {
  key_name   = "test-tgw-keypair"
  public_key = "${var.public_key}"
}

## Security Groups
## Need to create 4 of them as our Security Groups are linked to a VPC
resource "aws_security_group" "sec-group-vpc-1-ssh-icmp" {
  name        = "sec-group-vpc-1-ssh-icmp"
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = "${aws_vpc.vpc-1.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8             # the ICMP type number for 'Echo'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0             # the ICMP type number for 'Echo Reply'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sec-group-vpc-1-ssh-icmp"
    scenario = "${var.scenario}"
  }
}

resource "aws_security_group" "sec-group-vpc-2-ssh-icmp" {
  name        = "sec-group-vpc-2-ssh-icmp"
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = "${aws_vpc.vpc-2.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8             # the ICMP type number for 'Echo'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0             # the ICMP type number for 'Echo Reply'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sec-group-vpc-2-ssh-icmp"
    scenario = "${var.scenario}"
  }
}

resource "aws_security_group" "sec-group-vpc-3-ssh-icmp" {
  name        = "sec-group-vpc-3-ssh-icmp"
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = "${aws_vpc.vpc-3.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8             # the ICMP type number for 'Echo'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0             # the ICMP type number for 'Echo Reply'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sec-group-vpc-3-ssh-icmp"
    scenario = "${var.scenario}"
  }
}

resource "aws_security_group" "sec-group-vpc-4-ssh-icmp" {
  name        = "sec-group-vpc-4-ssh-icmp"
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = "${aws_vpc.vpc-4.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8             # the ICMP type number for 'Echo'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0             # the ICMP type number for 'Echo Reply'
    to_port     = 0             # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "sec-group-vpc-4-ssh-icmp"
    scenario = "${var.scenario}"
  }
}

resource "aws_instance" "test-tgw-instance1-dev" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.vpc-1-sub-a.id}"
  vpc_security_group_ids = ["${aws_security_group.sec-group-vpc-1-ssh-icmp.id}"]
  key_name               = "${aws_key_pair.test-tgw-keypair.key_name}"
  private_ip             = "10.10.1.10"

  tags = {
    Name     = "test-tgw-instance1-dev"
    scenario = "${var.scenario}"
    env      = "dev"
    az       = "${var.az1}"
    vpc      = "1"
  }
}

resource "aws_instance" "test-tgw-instance2-dev" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.vpc-2-sub-a.id}"
  vpc_security_group_ids = ["${aws_security_group.sec-group-vpc-2-ssh-icmp.id}"]
  key_name               = "${aws_key_pair.test-tgw-keypair.key_name}"
  private_ip             = "10.11.1.10"

  tags = {
    Name     = "test-tgw-instance2-dev"
    scenario = "${var.scenario}"
    env      = "dev"
    az       = "${var.az1}"
    vpc      = "2"
  }
}

resource "aws_instance" "test-tgw-instance3-shared" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.vpc-3-sub-a.id}"
  vpc_security_group_ids      = ["${aws_security_group.sec-group-vpc-3-ssh-icmp.id}"]
  key_name                    = "${aws_key_pair.test-tgw-keypair.key_name}"
  private_ip                  = "10.12.1.10"
  associate_public_ip_address = true

  tags = {
    Name     = "test-tgw-instance3-shared"
    scenario = "${var.scenario}"
    env      = "shared"
    az       = "${var.az1}"
    vpc      = "3"
  }
}

resource "aws_instance" "test-tgw-instance4-prod" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.vpc-4-sub-a.id}"
  vpc_security_group_ids = ["${aws_security_group.sec-group-vpc-4-ssh-icmp.id}"]
  key_name               = "${aws_key_pair.test-tgw-keypair.key_name}"
  private_ip             = "10.13.1.10"

  tags = {
    Name     = "test-tgw-instance4-prod"
    scenario = "${var.scenario}"
    env      = "prod"
    az       = "${var.az1}"
    vpc      = "4"
  }
}
