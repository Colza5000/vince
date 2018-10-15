variable "ami" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "security_groups" {
  type = "list"
}

variable "key_name" {
  default = ""
}

variable "name" {
  default = ""
}

variable "create_eip" {
  description = "If set to true, create EIP"
  default     = false
}
