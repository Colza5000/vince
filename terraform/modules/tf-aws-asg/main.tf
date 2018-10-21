provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami}"]
  }
}

resource "aws_launch_configuration" "launch_conf" {
  name_prefix             = "${var.name}-"
  image_id                = "${data.aws_ami.ec2_ami.id}"
  security_groups         = ["${var.security_groups}"]
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                    = "${var.name}_asg"
  launch_configuration    = "${aws_launch_configuration.launch_conf.name}"
  vpc_zone_identifier     = ["${var.vpc_zone_id}"]
  desired_capacity        = "${var.asg_size}"
  min_size                = "${var.asg_size}"
  max_size                = "${var.asg_size}"
  termination_policies    = ["OldestInstance"]

  lifecycle {
    create_before_destroy = true
  }

  tags {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }

}
