# module "openvpn" {
#   source          = "modules/tf-aws-instance"
#   name            = "openvpn"
#   ami             = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20180912"
#   instance_type   = "t2.medium"
#   security_groups = ["${aws_security_group.openvpn_sg.id}"]
#   key_name        = "colinmac"
#   create_eip      = true
# }

module "openvpn" {
  source           = "modules/open-vpn/"
  create           = true
  ami_id           = "ami-0886c7d045a7b6ac9"
  vpc_id           = "vpc-804cdbe8"
  instance_type    = "t2.medium"
  key_name         = "colinmac"
  external_cidrs   = "172.31.0.0/16"
  environment      = "dev"
  network_acl_id   = "acl-24c4b24c"
  public_subnet_id = "subnet-58812422"
}