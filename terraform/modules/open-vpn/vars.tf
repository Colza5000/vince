variable "create" {
  description = "Should the VPN be created e.g. true"
  default = false
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "external_cidrs" {
    description = "CIDRs of the external network"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "network_acl_id" {
  description = "Default Network ACL ID"
}

variable "public_subnet_id" {
  description = "Public subnet ID to create VPN in"
}

variable "ami_id" {
  default = "ami-17c5d373"
}

variable "ports" {
  description = "Additional ACL entries"
  type = "list"
  default = ["22","53","443","943","1194"]
}