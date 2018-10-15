module "openvpn" {
  source          = "modules/tf-aws-instance"
  name            = "openvpn"
  ami             = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20180912"
  instance_type   = "t2.medium"
  security_groups = ["${aws_security_group.openvpn_sg.id}"]
  key_name        = "colinmac"
  create_eip      = true
}
