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


# data "template_file" "user_data" { // EC2 cluster instances - booting script
#   template            = "${file("${path.module}/task-definitions/user_data.sh.tpl")}"
#
#   vars {
#     ecs_name          = "${aws_ecs_cluster.den_snipeit.name}"
#     aws_region        = "eu-west-2"
#     snipeit_revision  = "${aws_ecs_task_definition.den_snipeit_task.family}:${aws_ecs_task_definition.den_snipeit_task.revision}"
#   }
# }

resource "aws_launch_configuration" "launch_conf" {
  name_prefix             = "${var.name}-"
  image_id                = "${data.aws_ami.ec2_ami.id}"
  # iam_instance_profile    = "${aws_iam_instance_profile.instance_profile.name}"
  # security_groups         = ["${aws_security_group.jenkins.id}"]
  instance_type           = "${var.instance_type}"
  # key_name                = "snipeit-demo"
  # user_data               = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                    = "${var.name}_asg"
  launch_configuration    = "${aws_launch_configuration.launch_conf.name}"
  vpc_zone_identifier     = ["vpc-36d5f350"]
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
