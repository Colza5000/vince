module "jenkins" {
  source          = "modules/tf-aws-asg/"
  ami             = "RHEL-7.5_HVM_GA-*-x86_64-1-Hourly2-GP2"
  name            = "jenkins"
  instance_type   = "t2.medium"
  asg_size        = "1"
  key_name        = "colinmac"
  vpc_zone_id     = [""]
  security_groups = ["${aws_security_group.jenkins_sg.id}"]
}
