output "openvpn_external_ip" {
  value = "${aws_eip.openvpn.*.public_ip}"
}