variable "name" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "asg_size" {
  default = ""
}

variable "ami" {
  default = ""
}

variable "security_groups" {
  type = "list"
}

variable "key_name" {
  default = ""
}

variable "vpc_zone_id" {
  type = "list"
}
