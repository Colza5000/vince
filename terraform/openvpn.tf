module "openvpn" {
  source           = "modules/open-vpn/"
  create           = true
  ami_id           = "ami-0124f5d70260f2569"
  vpc_id           = "vpc-***"
  instance_type    = "t2.medium"
  key_name         = "colinmac"
  external_cidrs   = "172.31.0.0/16"
  environment      = "dev"
  network_acl_id   = "acl-***"
  public_subnet_id = "subnet-***"
}
