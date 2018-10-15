data "aws_ami" "ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami}"]
  }
}

resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.ec2_ami.id}"
  instance_type   = "${var.instance_type}"
  vpc_security_group_ids = ["${var.security_groups}"]
  # count           = 3
  key_name        = "${var.key_name}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  instance = "${aws_instance.instance.id}"
  count    = "${var.create_eip}"
}
