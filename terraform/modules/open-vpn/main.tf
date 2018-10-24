resource "aws_security_group" "openvpn" {
  count = "${var.create ? 1 : 0}"
  
  name = "OpenVPN"

  vpc_id = "${var.vpc_id}"

  # SSH access from den
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.external_cidrs)}"]
  }

  ingress {
    from_port = 943
    to_port = 943
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.external_cidrs)}"]
  }

  ingress {
    from_port = 1194
    to_port = 1194
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.external_cidrs)}"]
  }

  ingress {
    from_port = 1194
    to_port = 1194
    protocol = "udp"
    cidr_blocks = ["${split(",", var.external_cidrs)}"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.external_cidrs)}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "OpenVPN"
    Environment = "${var.environment}"
  }
}

data "template_file" "openvpn_script" {
  template = "${file("${path.module}/files/init.sh")}"

  # vars {
  #   elastic_address = "${aws_instance.openvpn.public_ip}"
  # }
}

data "template_cloudinit_config" "openvpn_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.openvpn_script.rendered}"
  }
}

resource "aws_instance" "openvpn" {
  count = "${var.create ? 1 : 0}"

  ami                    = "${var.ami_id}" // OpenVPN Access Server 2.1.9
  source_dest_check      = false
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.public_subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.openvpn.id}"]
  monitoring             = true
  user_data              = "${data.template_cloudinit_config.openvpn_config.rendered}"

  tags {
    Name        = "OpenVPN"
    Environment = "${var.environment}"
  }
}

resource "aws_network_acl_rule" "den-ingress" {
  count          = "${var.create ? length(split(",", var.external_cidrs)) * length(var.ports) : 0}"

  network_acl_id = "${var.network_acl_id}"
  rule_number    = "${110 + count.index}"
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${element(split(",", var.external_cidrs), count.index)}"
  from_port      = "${element(var.ports, floor(count.index / length(split(",", var.external_cidrs))))}"
  to_port        = "${element(var.ports, floor(count.index / length(split(",", var.external_cidrs))))}"
}

resource "aws_network_acl_rule" "den-egress" {
  count          = "${var.create ? length(split(",", var.external_cidrs)) : 0}"

  network_acl_id = "${var.network_acl_id}"
  rule_number    = "${210 + count.index}"
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "${element(split(",", var.external_cidrs), count.index)}"
  from_port      = 0
  to_port        = 0
}

resource "aws_eip" "openvpn" {
  count = "${var.create ? 1 : 0}"

  instance = "${aws_instance.openvpn.id}"
  vpc      = true
}